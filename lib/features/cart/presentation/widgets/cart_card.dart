import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/cart/data/models/cart_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.product,
    required this.ondelete,
    required this.onUpdate,
  });
  final CartItems product;
  final Function ondelete;
  final Function(int) onUpdate;
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
                imageUrl: product.itemProductImage ?? '',
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
                              product.itemProductName ?? '',
                              style: TextStyles.getTitle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff606060),
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Gap(8),
                            Text(
                              '\$${product.itemProductPriceAfterDiscount.toString()}',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if ((product.itemQuantity ?? 2) > 1) {
                            onUpdate((product.itemQuantity ?? 2) - 1);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Minimum is 1 !'),
                                backgroundColor: AppColors.primaryColor,
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xffE0E0E0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.remove),
                        ),
                      ),
                      Gap(5),
                      SizedBox(
                        width: 25,
                        child: Center(
                          child: Text(
                            product.itemQuantity.toString(),
                            style: TextStyles.getTitle(),
                          ),
                        ),
                      ),
                      Gap(5),
                      GestureDetector(
                        onTap: () {
                          if ((product.itemQuantity ?? 0) <
                              (product.itemProductStock ?? 0)) {
                            onUpdate((product.itemQuantity ?? 2) + 1);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Maximum is ${product.itemProductStock}!',
                                ),
                                backgroundColor: AppColors.primaryColor,
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xffE0E0E0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
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
