import 'package:gain_solutions_task/features/profile/data/profile_data_provider.dart';

import '../../../models/user_profile_model.dart';

class ProfileRepository {
  final ProfileDataProvider dataProvider;

  ProfileRepository({required this.dataProvider});

  Future<UserProfileModel> getProfileData() async {
    return dataProvider.getProfileData();
  }
}
