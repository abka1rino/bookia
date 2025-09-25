import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/home/data/models/slider/slider_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderShow extends StatefulWidget {
  SliderShow({super.key, required this.slider});
  final List<Sliders> slider;
  @override
  State<SliderShow> createState() => _SliderShowState();
}

class _SliderShowState extends State<SliderShow> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemBuilder: (context, index, realIdx) {
            print(widget.slider[1].image);
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(imageUrl:
                widget.slider[index].image ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
            );
          },
          itemCount: widget.slider.length,
          options: CarouselOptions(
            height: 150,
            viewportFraction: 1,
            initialPage: currentIndex,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.ease,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        Gap(15),
        SmoothPageIndicator(
          controller: PageController(initialPage: currentIndex),
          count: widget.slider.length,
          effect: ExpandingDotsEffect(
            dotColor: AppColors.borderColor,
            dotHeight: 7,
            dotWidth: 7,
            activeDotColor: AppColors.primaryColor,
            expansionFactor: 5,
          ),
          onDotClicked: (index) {},
        ),
      ],
    );
  }
}
