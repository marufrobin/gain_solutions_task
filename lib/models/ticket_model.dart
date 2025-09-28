import 'dart:ui';

class TicketModel {
  TicketModel({
    required this.id,
    required this.title,
    required this.ticketResponse,
    required this.description,
    required this.ticketRecipient,
    required this.tags,
    required this.status,
    required this.priority,
    required this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    required this.brand,
  });

  final int id;
  final String title;
  final TicketResponse? ticketResponse;
  final String description;
  final String ticketRecipient;
  final TicketStatus status;
  final TicketPriority priority;
  final DateTime dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String tags;
  final TicketBrand brand;

  static final List<TicketModel> tickets = [
    TicketModel(
      id: 12345678,
      title: 'Search view, which can display dynamic suggestions',
      description: 'Dynamic search suggestions in focused state',
      ticketRecipient: 'Michele',
      ticketResponse: TicketResponse.New,
      tags: 'tag one',
      status: TicketStatus.Open,
      priority: TicketPriority.Low,
      dueDate: DateTime.now().add(const Duration(days: 2)),
      createdAt: DateTime(2023, 12, 23, 15, 45),
      updatedAt: DateTime.now(),
      brand: TicketBrand.Gains,
    ),
    TicketModel(
      id: 12345693,
      title: 'First response overdue',
      ticketResponse: TicketResponse.firstResponseOverdue,
      description: 'Ticket subject small',
      ticketRecipient: 'Noah',
      tags: 'tag two',
      status: TicketStatus.Spam,
      priority: TicketPriority.Urgent,
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
      createdAt: DateTime(2023, 12, 23, 15, 43),
      updatedAt: DateTime.now(),
      brand: TicketBrand.GainsSolution,
    ),
    TicketModel(
      id: 12345695,
      title: 'Search view, customer responded',
      ticketResponse: TicketResponse.customerResponded,
      description: 'Dynamic search suggestion after customer response',
      ticketRecipient: 'Jonas',
      tags: 'tag three',
      status: TicketStatus.Closed,
      priority: TicketPriority.Medium,
      dueDate: DateTime.now().add(const Duration(days: 3)),
      createdAt: DateTime(2023, 12, 23, 15, 40),
      updatedAt: DateTime.now(),
      brand: TicketBrand.GainHQ,
    ),
    TicketModel(
      id: 12345696,
      title: 'Search view, customer responded',
      ticketResponse: TicketResponse.customerResponded,
      description: 'Dynamic search suggestion after customer response',
      ticketRecipient: 'Jonas',
      tags: 'tag four',
      status: TicketStatus.Closed,
      priority: TicketPriority.Medium,
      dueDate: DateTime.now().add(const Duration(days: 3)),
      createdAt: DateTime(2023, 12, 23, 15, 40),
      updatedAt: DateTime.now(),
      brand: TicketBrand.GainsSolution,
    ),
    TicketModel(
      id: 12345697,
      title: 'Search view, customer responded',
      ticketResponse: TicketResponse.customerResponded,
      description: 'Dynamic search suggestion after customer response',
      ticketRecipient: 'Jonas',
      tags: 'tag five',
      status: TicketStatus.Closed,
      priority: TicketPriority.Medium,
      dueDate: DateTime.now().add(const Duration(days: 3)),
      createdAt: DateTime(2023, 12, 23, 15, 40),
      updatedAt: DateTime.now(),
      brand: TicketBrand.GainHQ,
    ),
  ];
}

enum TicketResponse {
  New(title: 'New', color: Color(0xff00A1E0)),
  firstResponseOverdue(
    title: 'First response overdue',
    color: Color(0xFFFFA500),
  ),
  customerResponded(title: 'Customer responded', color: Color(0xff5A49B4));

  final String title;
  final Color color;

  const TicketResponse({required this.title, required this.color});
}

enum TicketPriority {
  Low(
    backgroundColor: Color(0xFFDCFCE7),
    dotColor: Color(0xFF10B981),
    textColor: Color(0xFF065F46),
  ),
  Urgent(
    backgroundColor: Color(0xFFFEF3C7),
    dotColor: Color(0xFFF59E0B),
    textColor: Color(0xFF92400E),
  ),
  Medium(
    backgroundColor: Color(0xFFFEF3C7),
    dotColor: Color(0xFFF59E0B),
    textColor: Color(0xFF92400E),
  ),
  High(
    backgroundColor: Color(0xFFFEE2E2),
    dotColor: Color(0xFFEF4444),
    textColor: Color(0xFF991B1B),
  );

  final Color backgroundColor;
  final Color dotColor;
  final Color textColor;

  const TicketPriority({
    required this.backgroundColor,
    required this.dotColor,
    required this.textColor,
  });
}

enum TicketStatus { Open, Closed, Spam }

enum TicketBrand { Gains, GainsSolution, GainHQ }
