import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/utils/text_style.dart';
import 'package:bookia/features/profile/data/models/account_section.dart';
import 'package:flutter/material.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key, required this.accountSectionModel});
  final AccountSectionModel accountSectionModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (accountSectionModel.route != null) {
          pushTo(context, accountSectionModel.route!);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            SizedBox(width: 10),
            Text(
              accountSectionModel.title,
              style: TextStyles.getTitle(fontSize: 18,fontWeight: FontWeight.w400)
            ),
            Expanded(child: SizedBox()),
            Icon(Icons.arrow_forward_ios, size: 20, color: Color(0xFF181725)),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
