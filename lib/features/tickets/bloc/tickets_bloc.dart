import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gain_solutions_task/features/tickets/data/tickets_repository.dart';

import '../../../models/ticket_model.dart';

part 'tickets_event.dart';
part 'tickets_state.dart';

class TicketsBloc extends Bloc<TicketsEvent, TicketsState> {
  final TicketsRepository repository;

  TicketBrand? _currentBrand;
  TicketPriority? _currentPriority;
  String? _currentTags;
  List<TicketModel> _allTickets = [];

  TicketsBloc({required this.repository}) : super(TicketsInitial()) {
    on<FetchTickets>(_onFetchTickets);
    on<FilterTickets>(_onFilterTickets);
    on<ClearFilters>(_onClearFilters);
  }

  Future<void> _onFetchTickets(
    FetchTickets event,
    Emitter<TicketsState> emit,
  ) async {
    emit(TicketsLoading());
    try {
      final tickets = await repository.getTickets();
      _allTickets = tickets;

      if (_hasActiveFilters()) {
        final filteredTickets = _applyCurrentFilters(tickets);
        emit(
          TicketsLoaded(
            tickets: filteredTickets,
            hasActiveFilters: true,
            activeFilters: FilterInfo(
              brand: _currentBrand,
              priority: _currentPriority,
              tags: _currentTags,
            ),
          ),
        );
      } else {
        emit(TicketsLoaded(tickets: tickets, hasActiveFilters: false));
      }
    } catch (e) {
      emit(TicketsError(message: e.toString()));
    }
  }

  Future<void> _onFilterTickets(
    FilterTickets event,
    Emitter<TicketsState> emit,
  ) async {
    emit(TicketsLoading());
    try {
      _currentBrand = event.brand;
      _currentPriority = event.priority;
      _currentTags = event.tags;

      if (_allTickets.isEmpty) {
        _allTickets = await repository.getTickets();
      }

      final filteredTickets = _applyCurrentFilters(_allTickets);

      emit(
        TicketsLoaded(
          tickets: filteredTickets,
          hasActiveFilters: _hasActiveFilters(),
          activeFilters: FilterInfo(
            brand: _currentBrand,
            priority: _currentPriority,
            tags: _currentTags,
          ),
        ),
      );
    } catch (e) {
      emit(TicketsError(message: e.toString()));
    }
  }

  void _onClearFilters(ClearFilters event, Emitter<TicketsState> emit) async {
    emit(TicketsLoading());
    try {
      _currentBrand = null;
      _currentPriority = null;
      _currentTags = null;

      if (_allTickets.isEmpty) {
        _allTickets = await repository.getTickets();
      }

      emit(TicketsLoaded(tickets: _allTickets, hasActiveFilters: false));
    } catch (e) {
      emit(TicketsError(message: e.toString()));
    }
  }

  bool _hasActiveFilters() {
    return _currentBrand != null ||
        _currentPriority != null ||
        (_currentTags != null && _currentTags!.isNotEmpty);
  }

  List<TicketModel> _applyCurrentFilters(List<TicketModel> tickets) {
    List<TicketModel> filteredTickets = List.from(tickets);

    if (_currentBrand != null) {
      filteredTickets = filteredTickets
          .where((ticket) => ticket.brand == _currentBrand)
          .toList();
    }

    if (_currentPriority != null) {
      filteredTickets = filteredTickets
          .where((ticket) => ticket.priority == _currentPriority)
          .toList();
    }

    if (_currentTags != null && _currentTags!.isNotEmpty) {
      filteredTickets = filteredTickets
          .where(
            (ticket) =>
                ticket.tags.toLowerCase().contains(_currentTags!.toLowerCase()),
          )
          .toList();
    }

    return filteredTickets;
  }

  FilterInfo? get currentFilters {
    if (_hasActiveFilters()) {
      return FilterInfo(
        brand: _currentBrand,
        priority: _currentPriority,
        tags: _currentTags,
      );
    }
    return null;
  }
}

class FilterInfo {
  final TicketBrand? brand;
  final TicketPriority? priority;
  final String? tags;

  const FilterInfo({this.brand, this.priority, this.tags});
}
