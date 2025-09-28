import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gain_solutions_task/features/contacts/data/contacts_repository.dart';

import '../../../models/contacts_model.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ContactsRepository repository;

  ContactsBloc({required this.repository}) : super(ContactsInitial()) {
    on<FetchContacts>(_onFetchContacts);
  }
  Future<void> _onFetchContacts(
    FetchContacts event,
    Emitter<ContactsState> emit,
  ) async {
    emit(ContactsLoading());
    try {
      final contacts = await repository.getContacts();
      emit(ContactsLoaded(contacts: contacts));
    } catch (e) {
      emit(ContactsError(message: e.toString()));
    }
  }
}
