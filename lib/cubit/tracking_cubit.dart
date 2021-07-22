import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/data/models/tracking.dart';
import 'package:htb_mobile/services/tracking_service.dart';

class TrackingCubit extends Cubit<Tracking> {
  final _service = TrackingService();
  TrackingCubit() : super(null);
  void getTrackingByItemCode(String code) async =>
      emit(await _service.getTrackingByItemCode(code));
}

// class TrackingStatusCubit extends Cubit<List<TrackingStatus>> {
//   final _service = TrackingService();
//   TrackingStatusCubit() : super([]);

//   void getTrackingStatus() async => emit(await _service.getTrackingStatuses());
// }
