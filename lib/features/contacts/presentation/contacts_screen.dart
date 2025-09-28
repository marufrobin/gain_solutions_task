import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gain_solutions_task/features/contacts/bloc/contacts_bloc.dart';
import 'package:gain_solutions_task/features/contacts/bloc/contacts_bloc.dart';

import '../../../app_config/app_assets_path.dart';
import '../../../models/contacts_model.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    context.read<ContactsBloc>().add(FetchContacts());
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Gain Solutions',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onSurface,
            fontSize: 28,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Stack(
              children: [
                Icon(Icons.notifications_none_outlined, size: 30),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Badge(label: Text('3'), backgroundColor: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                log(name: "value", value.isEmpty.toString());
                if (value.isEmpty) {
                  context.read<ContactsBloc>().add(FetchContacts());
                }
                context.read<ContactsBloc>().add(SearchContacts(query: value));
              },
              onSubmitted: (value) {
                context.read<ContactsBloc>().add(SearchContacts(query: value));
              },
              decoration: InputDecoration(
                hintText: 'Search Contacts',
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                prefixIconConstraints: BoxConstraints(
                  minHeight: 30,
                  minWidth: 30,
                ),
                prefixIcon: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(
                    AppAssetsPath.search,
                    colorFilter: ColorFilter.mode(
                      theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                fillColor: Color(0xffF3F4F8),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<ContactsBloc, ContactsState>(
              builder: (context, state) {
                return Text(
                  state is ContactsLoaded
                      ? '${state.contacts.length} Contacts'
                      : '0 Contacts',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ContactsBloc, ContactsState>(
                builder: (context, state) {
                  if (state is ContactsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ContactsLoaded) {
                    return ListView.builder(
                      itemCount: state.contacts.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _ContactWidget(
                          contact: state.contacts.elementAt(index),
                        );
                      },
                    );
                  } else if (state is ContactsError) {
                    return Center(
                      child: Text(
                        'Error: ${state.message}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Error',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactWidget extends StatelessWidget {
  final ContactsModel? contact;

  const _ContactWidget({this.contact});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          _userInfo(theme: theme, contact: contact),
          const SizedBox(height: 4),
          Row(
            spacing: 6,
            children: [
              Icon(
                Icons.email_outlined,
                size: 20,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              Text(
                contact?.email ?? '',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          Row(
            spacing: 6,
            children: [
              Icon(
                Icons.phone_in_talk_outlined,
                size: 20,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              Text(
                contact?.phone ?? '',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          Row(
            spacing: 6,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 20,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              Text(
                contact?.address ?? '',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row _userInfo({required ThemeData theme, required ContactsModel? contact}) {
    return Row(
      spacing: 16,
      children: [
        Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            border: Border.all(
              width: 1,
              style: BorderStyle.solid,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
            ),
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              contact?.personImageUrl ?? "",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          contact?.name ?? '',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 16,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const Spacer(),
        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
      ],
    );
  }
}
