import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/data/models/history_order.dart';
import 'package:htb_mobile/services/history_order_service.dart';

class OrderedHistoryCubit extends Cubit<OrderedHistory> {
  final _service = OrderedHistoryService();

  OrderedHistoryCubit() : super(null);

  void getOrderedHistory(int page) async =>
      emit(await _service.getOrderedHistories(page));

  void getAwaitingApproval(int page) async =>
      emit(await _service.getAwaitingApproval(page));
}
