part of 'edit_cart_cubit.dart';

@immutable
abstract class EditCartState {}

class EditCartInitial extends EditCartState {}
class EditCartError extends EditCartState {
  final String error;

  EditCartError({this.error});
}

class CartEdited extends EditCartState {}