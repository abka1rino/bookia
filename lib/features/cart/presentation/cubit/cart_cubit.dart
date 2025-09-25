import 'package:bookia/features/cart/data/models/cart_response.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
 CartCubit() : super(CartInitial());
  List<CartItems> cart = [];
  Future<void> getCart() async {
    emit(CartLoading());
    try {
      var res = await CartRepo.showCart();
      cart = res?.data?.cartItems ?? [];
      emit(CartSuccess());
    } catch (e) {
      emit(CartError());
    }
  }

  Future<void> removeFromCart({required int cartItemId}) async {
    emit(CartLoading());
    try {
      var res = await CartRepo.removeFromCart(cartItemId: cartItemId);
      if (res != null) {
        cart = res.data?.cartItems ?? [];
      }
      emit(CartSuccess());
    } catch (e) {
      emit(CartRemoveError());
    }
  }
  Future<void> updateCart({required int cartItemId,required int quantity}) async {
    try {
      var res = await CartRepo.updateCart(cartItemId: cartItemId,quantity: quantity);
      if (res != null) {
        cart = res.data?.cartItems ?? [];
      }
      emit(CartSuccess());
    } catch (e) {
      emit(CartRemoveError());
    }
  }
}


