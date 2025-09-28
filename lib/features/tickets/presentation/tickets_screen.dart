import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gain_solutions_task/app_config/app_time_formater.dart';
import 'package:gain_solutions_task/features/tickets/bloc/tickets_bloc.dart';
import 'package:gain_solutions_task/features/tickets/bloc/tickets_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app_config/app_assets_path.dart';
import '../../../app_config/app_routes.dart';
import '../../../models/ticket_model.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  void initState() {
    super.initState();
    final currentState = context.read<TicketsBloc>().state;
    if (currentState is! TicketsLoaded) {
      context.read<TicketsBloc>().add(FetchTickets());
    }
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
      body: BlocBuilder<TicketsBloc, TicketsState>(
        builder: (context, state) {
          if (state is TicketsLoaded) {
            return _body(state, theme, context);
          } else if (state is TicketsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TicketsError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            );
          } else {
            return const Center(child: Text('Loading...'));
          }
        },
      ),
    );
  }

  Widget _body(TicketsLoaded state, ThemeData theme, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _filterBarWidget(state, theme, context),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: state.tickets.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return TicketViewWidget(data: state.tickets.elementAt(index));
              },
            ),
          ),
        ],
      ),
    );
  }

  Row _filterBarWidget(
    TicketsLoaded state,
    ThemeData theme,
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${state.tickets.length} Tickets',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const Spacer(),
        if (state.hasActiveFilters)
          InkWell(
            onTap: () {
              context.read<TicketsBloc>().add(ClearFilters());
            },
            child: Text(
              "Clear Filters",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        SizedBox(width: 16),
        InkWell(
          onTap: () {
            context.pushNamed(AppRoutesNames.filter);
          },
          child: SvgPicture.asset(
            AppAssetsPath.filter,
            colorFilter: ColorFilter.mode(
              theme.colorScheme.onSurface.withValues(alpha: 0.7),
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}

class TicketViewWidget extends StatelessWidget {
  final TicketModel? data;

  const TicketViewWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xffF9FAFB),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: (data?.ticketResponse?.color ?? Colors.blue).withValues(
                alpha: 0.1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              data?.ticketResponse?.title ?? '',
              style: TextStyle(
                color: data?.ticketResponse?.color ?? Colors.blue,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Text(
            '#ID ${data?.id}',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),

          Text(
            data?.title ?? '',
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),

          // Author and timestamp row
          Row(
            spacing: 8,
            children: [
              Text(
                data?.ticketRecipient ?? '',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              Center(
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Text(
                AppTimeFormaterUtils.formatDateTime(data?.createdAt),
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 2),

          Divider(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            thickness: 2,
            height: 1.5,
          ),
          const SizedBox(height: 2),

          // Status badges row
          Row(
            children: [
              // Priority badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.2),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: data?.priority.dotColor ?? Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      data?.priority.name ?? '',
                      style: TextStyle(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Status badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  data?.status.name ?? '',
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
