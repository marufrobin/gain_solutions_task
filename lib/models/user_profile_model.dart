class UserProfileModel {
  final int id;
  final String firstName;
  final String lastName;
  final String name;
  final String email;
  final String phone;
  final String address;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<AssignedRoleModel> assignedRoles;

  UserProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.assignedRoles,
  });
}

class AssignedRoleModel {
  final int id;
  final String roleName;
  final String groupName;
  final String groupManagerName;

  AssignedRoleModel({
    required this.id,
    required this.roleName,
    required this.groupName,
    required this.groupManagerName,
  });
}
