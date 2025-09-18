import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/home/data/models/book%20list/book_list_response.dart';
import 'package:bookia/features/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Horisintalboxesshow extends StatelessWidget {
  const Horisintalboxesshow({
    super.key,
    required this.title,
    required this.booksList,
  });
  final String title;
  final List<Products> booksList;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyles.getTitle()),
        Gap(10),
        SizedBox(
          height: 280, // Set a fixed height for the ListView
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: booksList.length, // Example item count
            itemBuilder: (context, index) {
              return ProductCard(
                product: booksList[index],
              );
            },
            separatorBuilder: (context, index) => Gap(10),
          ),
        ),
      ],
    );
  }
}
