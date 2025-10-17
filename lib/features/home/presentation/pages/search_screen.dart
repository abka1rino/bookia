import 'package:bookia/components/app%20bar/app_bar.dart';
import 'package:bookia/components/inputs/custom_text_form_field.dart';
import 'package:bookia/core/extentions/decbouncer.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/home/presentation/widgets/vertical_boxes_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        var cubit = context.read<HomeCubit>();
        return Scaffold(
          appBar: AppBarBackSpace(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(20),
                  CustomTextFormField(
                    labelText: 'Search',
                    suffixIcon: Icon(
                      Icons.search,
                      color: AppColors.primaryColor,
                    ),
                    onChanged: (p0) {
                      Debouncer debouncer = Debouncer(milliseconds: 500);
                      debouncer.run(() {
                        cubit.search(p0);
                      });
                    },
                  ),
                  Gap(20),
                  cubit.searchedProducts.isNotEmpty
                      ? VerticalBoxesShow(
                          booksList: cubit.searchedProducts,
                          title: 'Search Result',
                        )
                      : Column(
                          children: [
                            Gap(180),
                            Text(
                              'write what you want to search for',
                              style: TextStyles.getBody(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
