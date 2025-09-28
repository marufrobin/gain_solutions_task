import 'package:gain_solutions_task/models/user_profile_model.dart';

class ProfileDataProvider {
  Future<UserProfileModel> getProfileData() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return UserProfileModel(
      id: 12345678,
      firstName: 'Maruf',
      lastName: 'Robin',
      name: 'Maruf Robin',
      email: 'marufrobin@gmail.com',
      phone: '+628123456789',
      address: '123 Main Street, Anytown, USA',
      createdAt: DateTime(2023, 12, 23, 15, 45),
      updatedAt: DateTime.now(),
    );
  }
}
