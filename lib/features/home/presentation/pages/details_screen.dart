import 'package:bookia/components/app%20bar/app_bar.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/home/data/models/book%20list/book_list_response.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});
  final Products product;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Some Thing Wrong!'),
              backgroundColor: AppColors.primaryColor,
            ),
          );
        } else if (state is HomeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                cubit.isInWishList(productId: product.id ?? 0)
                    ? 'Added to wish list'
                    : 'Removed from wish list',
              ),
              backgroundColor: AppColors.primaryColor,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarBackSpace(
            action: IconButton(
              icon: cubit.isInWishList(productId: product.id ?? 0)
                  ? SvgPicture.asset(
                      AppAssets.bookMarkIcon,
                      colorFilter: ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    )
                  : SvgPicture.asset(
                      AppAssets.bookMarkIcon,
                      colorFilter: ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                    ),
              onPressed: () {
                cubit.addRemoveWishList(productId: product.id ?? 0);
              },
            ),
          ),
          bottomNavigationBar: bottomNavigationBar(context),
          body: detailsBody(),
        );
      },
    );
  }

  SingleChildScrollView detailsBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Center(
          child: Column(
            children: [
              Hero(
                tag: product.key ?? '',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: product.image ?? '',
                    height: 270,
                  ),
                ),
              ),
              Gap(20),
              Text(product.name ?? '', style: TextStyles.getTitle()),
              Gap(15),
              Text(
                product.category ?? '',
                style: TextStyles.getBody(color: AppColors.primaryColor),
              ),
              Gap(15),
              Text(
                product.description?.substring(
                      3,
                      (product.description!.length - 4),
                    ) ??
                    '',
                style: TextStyles.getSmall(fontWeight: FontWeight.w600),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SafeArea bottomNavigationBar(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        child: Row(
          children: [
            Text(
              '\$${product.priceAfterDiscount.toString()}',
              style: TextStyles.getTitle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            SizedBox(
              width: 212,
              height: 60,
              child: MainButton(
                text: 'Add To Cart',
                onPressed: () {
                  cubit.addToCart(productId: product.id ?? 0).whenComplete(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added To Cart!'),
                        backgroundColor: AppColors.primaryColor,
                      ),
                    );
                  });
                },
                bgColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
