import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/data/models/ordered_history_detail.dart';
import 'package:htb_mobile/services/ordered_history_one_detail_service.dart';

class OrderedHistoryDetailCubit extends Cubit<OrderedHistoryDetail> {
  final _service = OrderedHistoryDetailService();

  OrderedHistoryDetailCubit() : super(null);

  void getOrderedHistoryDetail(int orderId) async =>
      emit(await _service.getOrderedHistoryDetail(orderId));

  void uploadReceipt(String filePath, String orderId) async {
    await _service.uploadReceipt(filePath, orderId);
    getOrderedHistoryDetail(int.parse(orderId));
  }

  void removeReceipt(String receiptId, String orderId) async {
    await _service.deleteReceipt(receiptId);
    getOrderedHistoryDetail(int.parse(orderId));
  }
}

class AwaitingApprovalCubit extends Cubit<List<AwaitingApproval>> {
  final _service = OrderedHistoryDetailService();
  AwaitingApprovalCubit() : super([]);

  void getAwaitingApprovalDetail(int orderId) async =>
      emit(await _service.getAwaitingApprovalDetail(orderId));
}
