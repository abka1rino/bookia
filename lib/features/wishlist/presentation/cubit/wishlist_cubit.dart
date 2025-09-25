import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/wishlist/data/models/wish_list_response.dart';
import 'package:bookia/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());
  List<Data1> wishlist = [];
  Future<void> getWishlist() async {
    emit(WishlistLoading());
    try {
      var res = await WishListRepo.showWishList();
      wishlist = res?.data?.data ?? [];
      emit(WishlistSuccess());
    } catch (e) {
      emit(WishlistError());
    }
  }

  Future<void> removeFromWishList({required int productId}) async {
    try {
      var res = await WishListRepo.removeFromWishList(productId: productId);
      if (res != null) {
        wishlist = res.data?.data ?? [];
      }
      emit(WishlistSuccess());
    } catch (e) {
      emit(WishlistRemoveError());
    }
  }
  Future<void> addToCart({required int productId}) async {
    try {
      await CartRepo.addToCart(productId: productId);
    } catch (e) {
      emit(AddToCartError());
    }
  }
}
