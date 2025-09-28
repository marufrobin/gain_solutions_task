part of 'contacts_bloc.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object?> get props => [];
}

final class FetchContacts extends ContactsEvent {}

final class SearchContacts extends ContactsEvent {
  final String? query;

  const SearchContacts({required this.query});
}
