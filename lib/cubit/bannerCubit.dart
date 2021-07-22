import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/data/models/banner.dart';
import 'package:htb_mobile/services/bannerService.dart';

class BannerCubit extends Cubit<BannerOT> {
  final _service = BannerService();

  BannerCubit() : super(BannerOT());

  void getBanners() async => emit(await _service.getBanners());
}
