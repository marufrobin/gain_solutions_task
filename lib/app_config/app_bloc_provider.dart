import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gain_solutions_task/features/contacts/bloc/contacts_bloc.dart';
import 'package:gain_solutions_task/features/contacts/data/contacts_data_provider.dart';
import 'package:gain_solutions_task/features/contacts/data/contacts_repository.dart';
import 'package:gain_solutions_task/features/profile/bloc/profile_bloc.dart';
import 'package:gain_solutions_task/features/profile/data/profile_data_provider.dart';
import 'package:gain_solutions_task/features/profile/data/profile_repository.dart';
import 'package:gain_solutions_task/features/tickets/bloc/tickets_bloc.dart';
import 'package:gain_solutions_task/features/tickets/data/tickets_data_provider.dart';
import 'package:gain_solutions_task/features/tickets/data/tickets_repository.dart';
import 'package:provider/single_child_widget.dart';

import '../features/dashboard/bloc/bottom_nav_index_cubit.dart';

class AppBlocProviderResolver {
  static final List<SingleChildWidget> blocProviders = [
    BlocProvider(create: (context) => DashBoardBottomNavIndexCubit()),
    BlocProvider(
      create: (context) =>
          TicketsBloc(repository: context.read<TicketsRepository>()),
    ),
    BlocProvider(
      create: (context) =>
          ContactsBloc(repository: context.read<ContactsRepository>()),
    ),
    BlocProvider(
      create: (context) =>
          ProfileBloc(repository: context.read<ProfileRepository>()),
    ),
  ];

  static final List<SingleChildWidget> repositoriesProviders = [
    RepositoryProvider<TicketsRepository>(
      create: (context) =>
          TicketsRepository(dataProvider: TicketsDataProvider()),
    ),
    RepositoryProvider<ContactsRepository>(
      create: (context) =>
          ContactsRepository(dataProvider: ContactsDataProvider()),
    ),
    RepositoryProvider<ProfileRepository>(
      create: (context) =>
          ProfileRepository(dataProvider: ProfileDataProvider()),
    ),
  ];
}
