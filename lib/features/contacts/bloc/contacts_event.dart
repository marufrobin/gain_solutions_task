part of 'contacts_bloc.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object?> get props => [];
}

final class FetchContacts extends ContactsEvent {}

final class UpdateContacts extends ContactsEvent {
  final ContactsModel? contact;

  const UpdateContacts({required this.contact});

  @override
  List<Object?> get props => [contact];
}
