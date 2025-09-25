import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/wishlist/data/models/wish_list_response.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WishlistCard extends StatelessWidget {
  const WishlistCard({
    super.key,
    required this.product,
    required this.ondelete,
  });
  final Data1 product;
  final Function ondelete;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushTo(context, Routes.details, extra: product.toProduct());
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),
              child: CachedNetworkImage(
                imageUrl: product.image ?? '',
                width: 100,
                height: 120,
              ),
            ),
            Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name ?? '',
                              style: TextStyles.getTitle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff606060),
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Gap(8),
                            Text(
                              '\$${product.price.toString()}',
                              style: TextStyles.getBody(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ondelete();
                        },
                        icon: Image.asset(AppAssets.closeIcon),
                      ),
                    ],
                  ),
                  Gap(15),
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: MainButton(
                      text: 'Add To Cart',
                      onPressed: () {
                        WishlistCubit()
                            .addToCart(productId: product.id ?? 0)
                            .whenComplete(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Added To Cart!'),
                                  backgroundColor: AppColors.primaryColor,
                                ),
                              );
                            });
                        ;
                      },
                      width: 180,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
