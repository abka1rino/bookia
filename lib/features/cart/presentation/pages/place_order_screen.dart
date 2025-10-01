import 'package:bookia/components/app%20bar/app_bar.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/inputs/custom_text_form_field.dart';
import 'package:bookia/core/constants/governorates.dart';
import 'package:bookia/core/extentions/app_regex.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlaceOrderScreen extends StatelessWidget {
  PlaceOrderScreen({super.key, required this.total});
  final formKey = GlobalKey<FormState>();
  final  total;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (BuildContext context, state) {
         if (state is CartRemoveError || state is CheckoutError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Something Wrong!'),
                  backgroundColor: AppColors.primaryColor,
                ),
              );
            } else if (state is CheckoutSuccess) {
              pushUntil(context, Routes.main,extra: 0);
            }
      },
      builder: (BuildContext context, CartState state) {
        var cubit = context.read<CartCubit>();
        return Scaffold(
          appBar: AppBarBackSpace(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Place Your Order',
                        style: TextStyles.getTitle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Gap(10),
                      Text(
                        'Don\'t worry! It occurs. Please enter the email address linked with your account.',
                        style: TextStyles.getBody(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      Gap(30),
                      CustomTextFormField(
                        labelText: 'Full Name',
                        validator: (val) {
                          if (val == null || val == '') {
                            return 'Please enter your full name';
                          } else {
                            return null;
                          }
                        },
                        controller: cubit.nameController,
                      ),
                      Gap(15),
                      CustomTextFormField(
                        labelText: 'Email',
                        validator: (val) {
                          if (val == null || val == '') {
                            return 'Please enter your email';
                          } else if (!AppRegex.email.hasMatch(val)) {
                            return 'Please enter a valid email';
                          } else {
                            return null;
                          }
                        },
                        controller: cubit.emailController,
                      ),
                      Gap(15),
                      CustomTextFormField(
                        labelText: 'Address',
                        validator: (val) {
                          if (val == null || val == '') {
                            return 'Please enter your address';
                          } else {
                            return null;
                          }
                        },
                        controller: cubit.addressController,
                      ),
                      Gap(15),
                      CustomTextFormField(
                        labelText: 'Phone',
                        validator: (val) {
                          if (val == null || val == '') {
                            return 'Please enter your phone number';
                          } else {
                            return null;
                          }
                        },
                        controller: cubit.phoneController,
                      ),
                      Gap(15),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Select Governorate',
                                      style: TextStyles.getTitle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Divider(),
                                    Expanded(
                                      child: SizedBox(
                                        child: ListView.separated(
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(
                                                governorates[index]['governorate_name_en'],
                                              ),
                                              onTap: () {
                                                cubit
                                                        .governorateController
                                                        .text =
                                                    governorates[index]['governorate_name_en'];
                                                cubit.governorateId = governorates[index]['id'];
                                                Navigator.pop(context);
                                              },
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return Divider();
                                          },
                                          itemCount: governorates.length,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: CustomTextFormField(
                          labelText: 'Governorate',
                          readOnly: true,
                          suffixIcon: RotatedBox(
                            quarterTurns: 3,
                            child: Icon(Icons.arrow_back_ios),
                          ),
                          controller: cubit.governorateController,
                        ),
                      ),
                      Gap(50),
                      Row(
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
                            '\$${total.toString()}',
                            style: TextStyles.getTitle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: MainButton(text: 'Submit Order', onPressed: () {
                          cubit.PlaceOrder();
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
