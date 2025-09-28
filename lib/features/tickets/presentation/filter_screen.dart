import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../app_config/app_assets_path.dart';
import '../../../models/ticket_model.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  TicketBrand? _selectedBrand;
  TicketPriority? _selectedPriority;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        centerTitle: false,
        elevation: 0,
        title: Text('Filters'),
        actions: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: theme.colorScheme.onSurface,
            ),
            child: Text(
              'Apply',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
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
            Text(
              'Brand',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _brandCheckList(theme),
            const SizedBox(height: 16),
            Text(
              'Priority',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border.all(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton(
                underline: SizedBox(),
                icon: Icon(Icons.keyboard_arrow_down_rounded),
                items: TicketPriority.values.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(
                      e.name,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
                borderRadius: BorderRadius.circular(8),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                isExpanded: true,
                value: _selectedPriority,
                hint: Text(
                  'Select Priority',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onChanged: (TicketPriority? value) {
                  setState(() {
                    _selectedPriority = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView _brandCheckList(ThemeData theme) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: TicketBrand.values.length,
      itemBuilder: (context, index) {
        final isSelected =
            _selectedBrand == TicketBrand.values.elementAt(index);
        void onChanged() {
          setState(() {
            _selectedBrand = TicketBrand.values.elementAt(index);
          });
        }

        return InkWell(
          onTap: onChanged,
          child: _brandWidget(
            theme: theme,
            title: TicketBrand.values.elementAt(index).name,
            isSelected: isSelected,
            onChanged: (value) {
              log(name: "value", value.toString());

              if (value != null && value) onChanged();
            },
          ),
        );
      },
    );
  }

  ListTile _brandWidget({
    required ThemeData theme,
    required String title,
    required bool isSelected,
    required Function(bool?) onChanged,
  }) {
    return ListTile(
      title: Row(
        spacing: 8,
        children: [
          Image.asset(AppAssetsPath.logoPNG, width: 28, height: 28),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      leading: Checkbox(value: isSelected, onChanged: onChanged),
    );
  }
}
