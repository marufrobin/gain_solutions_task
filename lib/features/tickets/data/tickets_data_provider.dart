import '../../../models/ticket_model.dart';

class TicketsDataProvider {
  Future<List<TicketModel>> getTickets() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return TicketModel.tickets;
  }
}
