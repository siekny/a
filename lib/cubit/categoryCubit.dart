import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/data/models/category.dart';
import 'package:htb_mobile/data/models/sub_category.dart';
import 'package:htb_mobile/services/categoryService.dart';

class CategoryCubit extends Cubit<Category> {
  final _service = CategoryService();

  CategoryCubit() : super(Category());

  void getCategories() async => emit(await _service.getCategories());

  void getAlibabaCategories() async =>
      emit(await _service.getAlibabaCategories());
}

class SubCategoryCubit extends Cubit<SubCategory> {
  final _service = CategoryService();

  SubCategoryCubit() : super(SubCategory());

   void getSubCategories(String _id) async =>
      emit(await _service.getSubCategories(_id));
}
