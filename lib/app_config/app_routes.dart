import 'package:flutter/material.dart';
import 'package:gain_solutions_task/features/contacts/presentation/contacts_screen.dart';
import 'package:gain_solutions_task/features/dashboard/presentation/dashboard_screen.dart';
import 'package:gain_solutions_task/features/profile/presentation/profile_screen.dart';
import 'package:gain_solutions_task/features/splash/presentation/splash_screen.dart';
import 'package:gain_solutions_task/features/tickets/presentation/tickets_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutesNames {
  static const String splashScreen = '/';
  static const String dashboard = '/dashboard';
  static const String tickets = '/tickets';
  static const String contacts = '/contacts';
  static const String profile = '/profile';
}

GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static final appRoutes = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutesNames.splashScreen,
    routes: [
      GoRoute(
        name: AppRoutesNames.splashScreen,
        path: AppRoutesNames.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRoutesNames.dashboard,
        path: AppRoutesNames.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        name: AppRoutesNames.tickets,
        path: AppRoutesNames.tickets,
        builder: (context, state) => const TicketsScreen(),
      ),
      GoRoute(
        name: AppRoutesNames.contacts,
        path: AppRoutesNames.contacts,
        builder: (context, state) => const ContactsScreen(),
      ),
      GoRoute(
        name: AppRoutesNames.profile,
        path: AppRoutesNames.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}
