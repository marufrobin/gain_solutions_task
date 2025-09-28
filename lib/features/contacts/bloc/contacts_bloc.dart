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
    on<SearchContacts>(_onSearchContacts);
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

  void _onSearchContacts(
    SearchContacts event,
    Emitter<ContactsState> emit,
  ) async {
    emit(ContactsLoading());
    try {
      final contacts = await repository.getContacts();
      List<ContactsModel> filteredContacts;

      if (event.query != null && event.query!.isNotEmpty) {
        final query = event.query!.toLowerCase();

        filteredContacts = contacts
            .where(
              (contact) =>
                  contact.name.toLowerCase().contains(query) ||
                  contact.firstName.toLowerCase().contains(query) ||
                  contact.lastName.toLowerCase().contains(query),
            )
            .toList();
      } else {
        filteredContacts = List.from(contacts);
      }
      emit(ContactsLoaded(contacts: filteredContacts));
    } catch (e) {
      emit(ContactsError(message: e.toString()));
    }
  }
}
