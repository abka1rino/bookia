import 'package:bookia/core/services/cashing/caching.dart';
import 'package:bookia/features/profile/data/models/account_section.dart';
import 'package:bookia/features/profile/presentation/widgets/account_section.dart';
import 'package:bookia/features/profile/presentation/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navigate to settings screen
            },
          ),
        ],
      ),
       body: SafeArea(
        child: Column(
          children: [
            ProfileHeader(name: Caching.getUserData()?.data?.user?.name??'', email:Caching.getUserData()?.data?.user?.email??''),
            Gap(20),
            Expanded(
              child: ListView.separated(
                itemCount: accountSections.length,
                separatorBuilder: (context, index) => Gap(10),
                itemBuilder: (context, index) {
                  return AccountSection(
                    accountSectionModel: accountSections[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}