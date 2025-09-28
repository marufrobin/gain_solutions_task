part of 'tickets_bloc.dart';

abstract class TicketsEvent extends Equatable {
  const TicketsEvent();

  @override
  List<Object?> get props => [];
}

final class FetchTickets extends TicketsEvent {}

final class FilterTickets extends TicketsEvent {
  final TicketBrand? brand;
  final TicketPriority? priority;
  final String? tags;

  const FilterTickets({this.brand, this.priority, this.tags});

  @override
  List<Object?> get props => [brand, priority, tags];
}

final class ClearFilters extends TicketsEvent {}
