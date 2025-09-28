import '../../../models/contacts_model.dart';

class ContactsDataProvider {
  Future<List<ContactsModel>> getContacts() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return ContactsModel.contacts;
  }
}
