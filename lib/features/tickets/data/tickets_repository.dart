import 'package:gain_solutions_task/features/tickets/data/tickets_data_provider.dart';

import '../../../models/ticket_model.dart';

class TicketsRepository {
  final TicketsDataProvider dataProvider;

  TicketsRepository({required this.dataProvider});
  Future<List<TicketModel>> getTickets() async {
    return dataProvider.getTickets();
  }
}
