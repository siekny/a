import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/data/models/image_response.dart';
import 'package:htb_mobile/services/searchService.dart';

class ImageUploadCubit extends Cubit<ImageReponse> {
  final _service = SearchSerivce();

  ImageUploadCubit() : super(ImageReponse());

  // void uploadImagetoAPI(_path) async =>
  //     emit(await _service.uploadImagetoAPI(_path));
  
}
