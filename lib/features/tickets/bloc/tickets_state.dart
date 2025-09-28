part of 'tickets_bloc.dart';

abstract class TicketsState extends Equatable {
  const TicketsState();

  @override
  List<Object?> get props => [];
}

class TicketsInitial extends TicketsState {}

final class TicketsLoaded extends TicketsState {
  final List<TicketModel?> tickets;

  const TicketsLoaded({required this.tickets});

  @override
  List<Object?> get props => [tickets];
}

final class TicketsLoading extends TicketsState {}

final class TicketsError extends TicketsState {
  final String? message;

  const TicketsError({required this.message});

  @override
  List<Object?> get props => [message];
}
