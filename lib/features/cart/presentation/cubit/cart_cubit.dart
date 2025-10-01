import 'package:bookia/core/services/cashing/caching.dart';
import 'package:bookia/features/cart/data/models/cart_response.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  List<CartItems> cart = [];
  dynamic cartTotal = 0;
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController governorateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  int governorateId = 0;
  Future<void> getCart() async {
    emit(CartLoading());
    try {
      var res = await CartRepo.showCart();
      cart = res?.data?.cartItems ?? [];
      cartTotal = res?.data?.total;
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
        cartTotal = res.data?.total;
      }
      emit(CartSuccess());
    } catch (e) {
      emit(CartRemoveError());
    }
  }

  Future<void> updateCart({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      var res = await CartRepo.updateCart(
        cartItemId: cartItemId,
        quantity: quantity,
      );
      if (res != null) {
        cart = res.data?.cartItems ?? [];
        cartTotal = res.data?.total;
      }
      emit(CartSuccess());
    } catch (e) {
      emit(CartRemoveError());
    }
  }

  Future<void> checkout() async {
    try {
      var res = await CartRepo.checkout();
      if (res == true) {
        emit(CheckoutSuccess());
      } else {
        emit(CheckoutError());
      }
    } catch (e) {
      emit(CheckoutError());
    }
  }

  Future<void> PlaceOrder() async {
    try {
      var res = await CartRepo.placeOrder(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        address: addressController.text,
        governorateId: governorateId,
      );
      if (res == true) {
        emit(CheckoutSuccess());
      } else {
        emit(CheckoutError());
      }
    } catch (e) {
      emit(CheckoutError());
    }
  }

  bool cartIsNotEmpty() {
    return cart.isNotEmpty;
  }

  initData() {
    var data = Caching.getUserData();
    nameController.text = data?.data?.user?.name ?? '';
    emailController.text = data?.data?.user?.email ?? '';
    phoneController.text = data?.data?.user?.phone ?? '';
    addressController.text = data?.data?.user?.address ?? '';
    governorateController.text = data?.data?.user?.city ?? '';
  }
}
