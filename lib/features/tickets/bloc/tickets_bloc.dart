import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gain_solutions_task/features/tickets/data/tickets_repository.dart';

import '../../../models/ticket_model.dart';

part 'tickets_event.dart';
part 'tickets_state.dart';

class TicketsBloc extends Bloc<TicketsEvent, TicketsState> {
  final TicketsRepository repository;

  TicketsBloc({required this.repository}) : super(TicketsInitial()) {
    on<FetchTickets>(_onFetchTickets);
  }

  Future<void> _onFetchTickets(
    FetchTickets event,
    Emitter<TicketsState> emit,
  ) async {
    emit(TicketsLoading());
    try {
      final tickets = await repository.getTickets();
      emit(TicketsLoaded(tickets: tickets));
    } catch (e) {
      emit(TicketsError(message: e.toString()));
    }
  }
}
