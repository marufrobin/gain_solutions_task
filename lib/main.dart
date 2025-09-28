import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gain_solutions_task/app_config/app_bloc_provider.dart';
import 'package:gain_solutions_task/app_config/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: AppBlocProviderResolver.repositoriesProviders,
      child: MultiBlocProvider(
        providers: AppBlocProviderResolver.blocProviders,
        child: MaterialApp.router(
          title: 'Gain Solutions Task',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff00A1E0)),
          ),
          routerConfig: AppRoutes.appRoutes,
        ),
      ),
    );
  }
}
