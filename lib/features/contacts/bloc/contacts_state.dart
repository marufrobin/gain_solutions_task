part of 'contacts_bloc.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object?> get props => [];
}

class ContactsInitial extends ContactsState {}

final class ContactsLoaded extends ContactsState {
  final List<ContactsModel?> contacts;

  const ContactsLoaded({required this.contacts});

  @override
  List<Object?> get props => [contacts];
}

final class ContactsLoading extends ContactsState {}

final class ContactsError extends ContactsState {
  final String? message;

  const ContactsError({required this.message});

  @override
  List<Object?> get props => [message];
}
