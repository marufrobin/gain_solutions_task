import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../app_config/app_assets_path.dart';
import '../../../models/ticket_model.dart';
import '../bloc/tickets_bloc.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  TicketBrand? _selectedBrand;
  TicketPriority? _selectedPriority;

  final _searchController = TextEditingController();

  final List<String> _tags = [
    'tag one',
    'tag two',
    'tag three',
    'tag four',
    'tag five',
  ];

  @override
  void initState() {
    super.initState();
    _loadCurrentFilters();
  }

  void _loadCurrentFilters() {
    final currentState = context.read<TicketsBloc>().state;
    if (currentState is TicketsLoaded && currentState.activeFilters != null) {
      final filters = currentState.activeFilters!;
      setState(() {
        _selectedBrand = filters.brand;
        _selectedPriority = filters.priority;
        _searchController.text = filters.tags ?? '';
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    context.read<TicketsBloc>().add(
      FilterTickets(
        brand: _selectedBrand,
        priority: _selectedPriority,
        tags: _searchController.text.trim().isNotEmpty
            ? _searchController.text.trim()
            : null,
      ),
    );
    context.pop();
  }

  void _clearFilters() {
    setState(() {
      _selectedBrand = null;
      _selectedPriority = null;
      _searchController.clear();
    });
    context.read<TicketsBloc>().add(ClearFilters());
    context.pop();
  }

  bool get _hasActiveFilters {
    return _selectedBrand != null ||
        _selectedPriority != null ||
        _searchController.text.trim().isNotEmpty;
  }

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
        title: const Text('Filters'),
        actions: [
          TextButton(
            onPressed: _applyFilters,
            child: Text(
              'Apply',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: _hasActiveFilters
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.onSurface.withValues(alpha: 0.1),
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
            _priorityDropDownWidget(theme),
            const SizedBox(height: 16),
            Text(
              'Tags',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'Search Tags',
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                prefixIconConstraints: const BoxConstraints(
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
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                          });
                        },
                      )
                    : null,
                fillColor: const Color(0xffF3F4F8),
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
            Wrap(
              spacing: 8,
              children: _tags
                  .map(
                    (e) => _tagsWidget(
                      theme: theme,
                      title: e,
                      onChanged: (value) {
                        if (value != null && value.isNotEmpty) {
                          setState(() {
                            _searchController.text = value;
                          });
                        }
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Container _tagsWidget({
    required ThemeData theme,
    required String title,
    required Function(String?) onChanged,
  }) {
    final isSelected =
        _searchController.text.toLowerCase() == title.toLowerCase();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? theme.colorScheme.primary.withValues(alpha: 0.1)
            : theme.colorScheme.surface,
        border: Border.all(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface.withValues(alpha: 0.1),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onChanged(title);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _priorityDropDownWidget(ThemeData theme) {
    return Container(
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
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
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
    );
  }

  ListView _brandCheckList(ThemeData theme) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: TicketBrand.values.length,
      itemBuilder: (context, index) {
        final brand = TicketBrand.values.elementAt(index);
        final isSelected = _selectedBrand == brand;

        return InkWell(
          onTap: () {
            setState(() {
              // Toggle selection: if already selected, unselect it
              _selectedBrand = isSelected ? null : brand;
            });
          },
          child: _brandWidget(
            theme: theme,
            title: brand.name,
            isSelected: isSelected,
            onChanged: (value) {
              setState(() {
                _selectedBrand = value == true ? brand : null;
              });
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
