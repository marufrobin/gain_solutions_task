import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gain_solutions_task/app_config/app_assets_path.dart';
import 'package:gain_solutions_task/features/contacts/presentation/contacts_screen.dart';
import 'package:gain_solutions_task/features/profile/presentation/profile_screen.dart';
import 'package:gain_solutions_task/features/tickets/presentation/tickets_screen.dart';

import '../bloc/bottom_nav_index_cubit.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Widget> _screens = [
    const TicketsScreen(),
    const ContactsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocBuilder<DashBoardBottomNavIndexCubit, int>(
        builder: (context, state) {
          return _screens[state];
        },
      ),
      bottomNavigationBar: BlocBuilder<DashBoardBottomNavIndexCubit, int>(
        builder: (context, state) {
          return NavigationBar(
            selectedIndex: state,
            backgroundColor: theme.colorScheme.surface,
            elevation: 2,
            shadowColor: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            onDestinationSelected: (value) {
              context.read<DashBoardBottomNavIndexCubit>().updateIndex(value);
            },
            destinations: [
              NavigationDestination(
                icon: SvgPicture.asset(
                  AppAssetsPath.ticket,
                  width: 24,
                  height: 24,
                ),
                selectedIcon: SvgPicture.asset(
                  AppAssetsPath.ticketFill,
                  height: 24,
                  width: 24,
                ),
                label: 'Tickets',
              ),
              NavigationDestination(
                icon: SvgPicture.asset(AppAssetsPath.contacts),
                selectedIcon: SvgPicture.asset(AppAssetsPath.contactsFill),
                label: 'Contacts',
              ),
              NavigationDestination(
                icon: SvgPicture.asset(AppAssetsPath.person),
                selectedIcon: SvgPicture.asset(AppAssetsPath.personFill),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
