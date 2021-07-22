import 'package:bloc/bloc.dart';
import 'package:htb_mobile/data/models/product_detail.dart';
import 'package:htb_mobile/data/repository.dart';
import 'package:htb_mobile/data/response/cart_response.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final Repository _repository = Repository();

  CartCubit() : super(CartInitial());

  void viewCart(String token) async {
    final responses = await _repository.viewCart(token);


    if(responses["code"]==200){
      var carts = responses["data"]["list_carts"] as List<dynamic>;

      var lists = carts.map((cart) => CartResponse.fromJson(cart)).toList();

      emit(CartLoaded(carts: lists));
    }else{
      emit(CartLoaded(carts: []));
    }
  }

  void deleteCart(String token, String id) async {
    final responses = await _repository.deleteCart(token, id);

    var carts = responses["data"]["list_carts"] as List<dynamic>;

    var lists = carts.map((cart) => CartResponse.fromJson(cart)).toList();

    emit(CartLoaded(carts: lists));
  }

  void checkout(String token, List<String> ids) async {
    _repository.checkout(token, ids);
  }

  Future<int> addCart(String token, ProductDetail product) async {
    final responses = await _repository.addCart(token, product);
    return responses;
  }

  void updateCart() {
    final currentState = state;
    if (currentState is CartLoaded) emit(CartLoaded(carts: currentState.carts));
  }
}
