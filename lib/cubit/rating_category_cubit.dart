import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/data/models/rating_category.dart';
import 'package:htb_mobile/services/ratingCategoryService.dart';

class RatingCategoryCubit extends Cubit<RatingCategory> {
  final _service = RatingCategoryService();

  RatingCategoryCubit() : super(RatingCategory());

  void getRatingCategories() async => emit(await _service.getRatingCategories());
}
