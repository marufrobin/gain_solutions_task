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
      assignedRoles: [
        AssignedRoleModel(
          id: 1,
          roleName: 'Developer',
          groupName: 'Development Team',
          groupManagerName: 'John Doe',
        ),
        AssignedRoleModel(
          id: 2,
          roleName: 'Designer',
          groupName: 'Design Team',
          groupManagerName: 'Jane Doe',
        ),
        AssignedRoleModel(
          id: 3,
          roleName: 'QA',
          groupName: 'QA Team',
          groupManagerName: 'Bob Smith',
        ),
      ],
    );
  }
}
