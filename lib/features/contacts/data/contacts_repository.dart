import 'package:gain_solutions_task/features/contacts/data/contacts_data_provider.dart';

import '../../../models/contacts_model.dart';

class ContactsRepository {
  final ContactsDataProvider dataProvider;

  ContactsRepository({required this.dataProvider});

  Future<List<ContactsModel>> getContacts() async {
    return dataProvider.getContacts();
  }
}
