import 'package:bloc/bloc.dart';
import 'package:htb_mobile/cubit/cart_cubit.dart';
import 'package:htb_mobile/data/models/product_detail.dart';
import 'package:htb_mobile/data/repository.dart';
import 'package:meta/meta.dart';

part 'edit_cart_state.dart';

class EditCartCubit extends Cubit<EditCartState> {
  final Repository repository;
  final CartCubit cartCubit;

  EditCartCubit({this.repository, this.cartCubit}) : super(EditCartInitial());

  Future<ProductDetail> updateCart(int oldQty,String cartId, bool isIncrement,double price) async{
    var result =await repository.updateCart(oldQty,cartId,isIncrement,price);
    if(result == null){
      emit(EditCartError(error: "error"));
      return null;
    }else{
      cartCubit.updateCart();
      emit(CartEdited());
      return result;
    }
    // repository.updateCart(oldQty,cartId,isIncrement,price).then((result) {
    //   if (result !=null) {
    //
    //   }else{
    //
    //   }
    // }).catchError((){return null;});
  }

}
