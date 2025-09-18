import 'package:bookia/core/services/api/api_endpoints.dart';
import 'package:bookia/features/home/data/models/book%20list/book_list_response.dart';
import 'package:bookia/features/home/data/models/slider/slider_list.dart';
import 'package:bookia/features/home/data/repo/home_repo.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit():super(HomeState());
      List<Products> allProducts = [];
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
}
