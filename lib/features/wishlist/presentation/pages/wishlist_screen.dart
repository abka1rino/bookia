import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:bookia/features/wishlist/presentation/widgets/wishlist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistCubit()..getWishlist(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Wishlist',
            style: TextStyles.getTitle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (BuildContext context, state) {
            var cubit = context.read<WishlistCubit>();
            if (state is WishlistRemoveError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Something Wrong!'),
                  backgroundColor: AppColors.primaryColor,
                ),
              );
            } else if (state is! WishlistSuccess) {
              return const Center(child: CircularProgressIndicator());
            }
            if (cubit.wishlist.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.bookMarkIcon,
                      colorFilter: ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                      width: 100,
                      height: 100,
                    ),
                    Gap(20),
                    Text(
                      'Your wishlist is empty',
                      style: TextStyles.getTitle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
              itemBuilder: (context, index) {
                return WishlistCard(
                  product: cubit.wishlist[index],
                  ondelete: () {
                    cubit.removeFromWishList(
                      productId: cubit.wishlist[index].id ?? 0,
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Color(0xffF0F0F0),
                  endIndent: 25,
                  indent: 25,
                );
              },
              itemCount: cubit.wishlist.length,
            );
          },
        ),
      ),
    );
  }
}
