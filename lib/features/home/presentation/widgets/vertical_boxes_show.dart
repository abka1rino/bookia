import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/home/data/models/book%20list/book_list_response.dart';
import 'package:bookia/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class VerticalBoxesShow extends StatelessWidget {
  const VerticalBoxesShow({super.key, required this.booksList});

  final List<Products> booksList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('All Books', style: TextStyles.getTitle()),
        Gap(10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: .65,
          ),
          itemCount: booksList.length,
          itemBuilder: (context, index) {
            return ProductCard(product: booksList[index]);
          },
        ),
      ],
    );
  }
}
