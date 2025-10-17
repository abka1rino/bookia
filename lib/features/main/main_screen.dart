import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/cart/presentation/pages/cart_screen.dart';
import 'package:bookia/features/home/presentation/pages/home_screen.dart';
import 'package:bookia/features/profile/presentation/pages/profile_screen.dart';
import 'package:bookia/features/wishlist/presentation/pages/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key, this.initialIndex});
  final int? initialIndex;
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    HomeScreen(),
    WishlistScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  int index = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      index = widget.initialIndex ?? index;
    });
  }
  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
      setState(() {
        index = widget.initialIndex ?? index;
      });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: index,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: 'home',
            icon: SvgPicture.asset(AppAssets.homeIcon),
            activeIcon: SvgPicture.asset(
              AppAssets.homeIcon,
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'wishlist',
            icon: SvgPicture.asset(AppAssets.bookMarkIcon),
            activeIcon: SvgPicture.asset(
              AppAssets.bookMarkIcon,
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'cart',
            icon: SvgPicture.asset(AppAssets.cartIcon),
            activeIcon: SvgPicture.asset(
              AppAssets.cartIcon,
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'profile',
            icon: SvgPicture.asset(AppAssets.profileIcon),
            activeIcon: SvgPicture.asset(
              AppAssets.profileIcon,
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
        onTap: (val) {
          setState(() {
            index = val;
          });
        },
      ),
    );
  }
}
