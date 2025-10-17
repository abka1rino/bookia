import 'dart:developer';

import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/core/services/cashing/caching.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/home/data/models/book%20list/book_list_response.dart';
import 'package:bookia/features/home/data/models/slider/slider_list.dart';
import 'package:bookia/features/home/data/repo/home_repo.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());
  List<Products> allProducts = [];
  List<Products> searchedProducts = [];
  List<Products> newArrivalsProducts = [];
  List<Products> bestSellerProducts = [];
  List<Sliders> sliderList = [];
  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      var res = await Future.wait([
        HomeRepo.getProducts(ApiEndpoints.allProducts),
        HomeRepo.getProducts(ApiEndpoints.newArrivslsProducts),
        HomeRepo.getProducts(ApiEndpoints.bestSellerProducts),
        HomeRepo.getSliders(ApiEndpoints.sliders),
      ]);
      allProducts = (res[0] as BookListResponse).data!.products ?? [];
      newArrivalsProducts = (res[1] as BookListResponse).data!.products ?? [];
      bestSellerProducts = (res[2] as BookListResponse).data!.products ?? [];
      sliderList = (res[3] as SliderList).data!.sliders ?? [];
      emit(HomeSuccess());
    } catch (e) {
      emit(HomeError());
    }
    return;
  }

  Future<void> search(String productName) async {
    emit(HomeLoading());
    try {
      var res = await HomeRepo.searchProducts(
        ApiEndpoints.allProducts,
        productName,
      );
      searchedProducts = res?.data?.products ?? [];
      emit(HomeSuccess());
    } catch (e) {
      emit(HomeError());
    }
    return;
  }

  Future<void> addRemoveWishList({required int productId}) async {
    emit(HomeLoading());
    try {
      await WishListRepo.addRemoveFromWishList(productId: productId);
      emit(HomeSuccess());
    } catch (e) {
      log(e.toString());
      emit(HomeError());
    }
  }

  bool isInWishList({required int productId}) {
    var wishList = Caching.getWishListData()?.data?.data;
    return wishList?.any((item) => item.id == productId) ?? false;
  }

  Future<bool> addToCart({required int productId}) async {
    try {
      await CartRepo.addToCart(productId: productId);
      emit(AddToCartSuccess());
      return true;
    } catch (e) {
      emit(AddToCartError());
      return false;
    }
  }
}
