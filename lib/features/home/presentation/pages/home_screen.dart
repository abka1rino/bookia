import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/home/presentation/widgets/horisintal_boxes_show.dart';
import 'package:bookia/features/home/presentation/widgets/slider_show.dart';
import 'package:bookia/features/home/presentation/widgets/vertical_boxes_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            SvgPicture.asset(AppAssets.logo, width: 45, height: 30),
            SizedBox(width: 3),
            Text(
              'Bookia',
              style: TextStyles.getTitle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppAssets.searchIcon),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = context.read<HomeCubit>();
          if (state is HomeError || state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SliderShow(slider: cubit.sliderList),
                  Gap(20),
                  Horisintalboxesshow(
                    title: 'Best Seller',
                    booksList: cubit.bestSellerProducts,
                  ),
                  Gap(20),
                  Horisintalboxesshow(
                    title: 'New Arrivals',
                    booksList: cubit.newArrivalsProducts,
                  ),
                  Gap(20),
                  VerticalBoxesShow(booksList: cubit.allProducts),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
