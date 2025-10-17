import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/cart/presentation/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Cart',
            style: TextStyles.getTitle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: BlocConsumer<CartCubit, CartState>(
          builder: (BuildContext context, state) {
            var cubit = context.read<CartCubit>();
            if (state is CartError && state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (cubit.cart.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.cartIcon,
                      colorFilter: ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                      width: 100,
                      height: 100,
                    ),
                    Gap(20),
                    Text(
                      'Your cart is empty',
                      style: TextStyles.getTitle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: SizedBox(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return CartCard(
                          product: cubit.cart[index],
                          ondelete: () {
                            cubit.removeFromCart(
                              cartItemId: cubit.cart[index].itemId ?? 0,
                            );
                          },
                          onUpdate: (val) {
                            cubit.updateCart(
                              cartItemId: cubit.cart[index].itemId ?? 0,
                              quantity: val,
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
                      itemCount: cubit.cart.length,
                    ),
                  ),
                ),
                cubit.cartIsNotEmpty()
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total:',
                                  style: TextStyles.getTitle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  '\$ ${cubit.cartTotal}',
                                  style: TextStyles.getTitle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: MainButton(
                              text: 'Checkout',
                              onPressed: () {
                                cubit.checkout();
                              },
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
              ],
            );
          },
          listener: (BuildContext context, CartState state) {
            if (state is CartRemoveError || state is CheckoutError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Something Wrong!'),
                  backgroundColor: AppColors.primaryColor,
                ),
              );
            } else if (state is CheckoutSuccess) {
              pushTo(
                context,
                Routes.placeOrder,
                extra: context.read<CartCubit>().cartTotal,
              );
            }
          },
        ),
      ),
    );
  }
}
