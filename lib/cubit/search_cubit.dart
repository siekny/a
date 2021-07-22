import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/data/models/global_items.dart';
import 'package:htb_mobile/services/searchService.dart';

class SearchCubit extends Cubit<GlobalItems> {
  final _service = SearchSerivce();

  SearchCubit() : super(GlobalItems());

  void getRatingCategories(id, from, to, order) async =>
      emit(await _service.getSearchResultbyCategoryID(id, from, to, order));
  void getProductByTitle(title, from, to, order) async =>
      emit(await _service.getSearchResultbyCategoryID(title, from, to, order));

  void getSearchResultbyImage(photo, from , to) async =>
      emit(await _service.getSearchResultbyImage(photo, from , to));
}
