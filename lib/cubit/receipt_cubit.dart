import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/data/models/receipt.dart';
import 'package:htb_mobile/services/receipt_service.dart';

class ReceiptCubit extends Cubit<Receipt> {
  final _service = ReceiptService();

  ReceiptCubit() : super(null);

  void getReceipt(int page) async => emit(await _service.getReceipt(page));
}
