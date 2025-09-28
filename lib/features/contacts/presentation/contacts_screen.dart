import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app_config/app_assets_path.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _searchController = TextEditingController();

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
            Text(
              '42 Contacts',
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 14,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _ContactWidget();
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
  const _ContactWidget({super.key});

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
          _userInfo(theme),
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
                "marufrobin00@gmail.com",
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
                "+628123456789",
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
                "123 Main Street, Anytown, USA",
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

  Row _userInfo(ThemeData theme) {
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
              "https://avatars.githubusercontent.com/u/47666475?v=4",
            ),
          ),
        ),
        Text(
          "Maruf Robin",
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
