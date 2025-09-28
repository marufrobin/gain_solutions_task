part of 'tickets_bloc.dart';

abstract class TicketsState extends Equatable {
  const TicketsState();

  @override
  List<Object?> get props => [];
}

final class TicketsInitial extends TicketsState {}

final class TicketsLoading extends TicketsState {}

final class TicketsLoaded extends TicketsState {
  final List<TicketModel> tickets;
  final bool hasActiveFilters;
  final FilterInfo? activeFilters;

  const TicketsLoaded({
    required this.tickets,
    this.hasActiveFilters = false,
    this.activeFilters,
  });

  @override
  List<Object?> get props => [tickets, hasActiveFilters, activeFilters];
}

final class TicketsError extends TicketsState {
  final String message;

  const TicketsError({required this.message});

  @override
  List<Object> get props => [message];
}
