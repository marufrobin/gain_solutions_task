import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gain_solutions_task/features/tickets/data/tickets_repository.dart';

part 'tickets_event.dart';
part 'tickets_state.dart';

class TicketsBloc extends Bloc<TicketsEvent, TicketsState> {
  final TicketsRepository repository;

  TicketsBloc({required this.repository}) : super(TicketsInitial()) {
    on<TicketsEvent>((event, emit) {});
  }
}
