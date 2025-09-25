import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/home/data/models/book%20list/book_list_response.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Products product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushTo(context, Routes.details, extra: product);
      },
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: Color(0xffF5EFE1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Hero(
                  tag: product.key ?? '',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: CachedNetworkImage(
                      imageUrl: product.image ?? '',
                      width: 140,
                      height: 175,
                    ),
                  ),
                ),
              ),
              Text(
                product.name ?? '',
                style: TextStyles.getBody(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price.toString()}',
                    style: TextStyles.getBody(fontWeight: FontWeight.w600),
                  ),
                  MainButton(
                    text: 'Buy',
                    onPressed: () {
                      HomeCubit()
                          .addToCart(productId: product.id ?? 0)
                          .whenComplete(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Added To Cart!'),
                                backgroundColor: AppColors.primaryColor,
                              ),
                            );
                          });
                    },
                    width: 80,
                    height: 28,
                    textStyle: TextStyles.getBody(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
