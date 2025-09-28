class ContactsModel {
  ContactsModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.email,
    required this.personImageUrl,
    required this.phone,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String name;
  final String email;
  final String personImageUrl;
  final String phone;
  final String address;
  final DateTime createdAt;
  final DateTime updatedAt;

  static final List<ContactsModel> contacts = [
    ContactsModel(
      id: 12345678,
      name: 'Maruf Robin',
      firstName: 'Maruf',
      lastName: 'Robin',
      email: 'marufrobin@gmail.com',
      personImageUrl: "https://avatars.githubusercontent.com/u/47666475?v=4",
      phone: '+628123456789',
      address: '123 Main Street, Anytown, USA',
      createdAt: DateTime(2023, 12, 23, 15, 45),
      updatedAt: DateTime.now(),
    ),
    ContactsModel(
      id: 12345693,
      name: 'Michele Robin',
      firstName: 'Michele',
      lastName: 'Robin',
      email: 'michele@gmail.com',
      phone: '+628123456789',
      personImageUrl:
          'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      address: '123 Main Street, Anytown, USA',
      createdAt: DateTime(2023, 12, 23, 15, 43),
      updatedAt: DateTime.now(),
    ),
    ContactsModel(
      id: 12345695,
      name: 'Noah Robin',
      firstName: 'Noah',
      lastName: 'Robin',
      email: 'noah@gmail.com',
      personImageUrl:
          "https://plus.unsplash.com/premium_photo-1678197937465-bdbc4ed95815?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      phone: '+628123456789',
      address: '123 Main Street, Anytown, USA',
      createdAt: DateTime(2023, 12, 23, 15, 40),
      updatedAt: DateTime.now(),
    ),
    ContactsModel(
      id: 12345696,
      name: 'Jonas Robin',
      firstName: 'Jonas',
      lastName: 'Robin',
      email: 'jonas@gmail.com',
      personImageUrl:
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      phone: '+628123456789',
      address: '123 Main Street, Anytown, USA',
      createdAt: DateTime(2023, 12, 23, 15, 40),
      updatedAt: DateTime.now(),
    ),
    ContactsModel(
      id: 12345697,
      name: 'Jake jilenhal',
      firstName: 'Jake',
      lastName: 'jilenhal',
      email: 'jilenhal@gmail.com',
      personImageUrl:
          "https://plus.unsplash.com/premium_photo-1689539137236-b68e436248de?q=80&w=871&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      phone: '+628123456789',
      address: '123 Main Street, Anytown, USA',
      createdAt: DateTime(2023, 12, 23, 15, 40),
      updatedAt: DateTime.now(),
    ),
  ];
}
