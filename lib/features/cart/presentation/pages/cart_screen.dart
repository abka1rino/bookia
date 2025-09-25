import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/cart/presentation/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        body: BlocBuilder<CartCubit, CartState>(
          builder: (BuildContext context, state) {
            var cubit = context.read<CartCubit>();
            if (state is CartRemoveError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Something Wrong!'),
                  backgroundColor: AppColors.primaryColor,
                ),
              );
            } else if (state is! CartSuccess) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.separated(
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
            );
          },
        ),
      ),
    );
  }
}
