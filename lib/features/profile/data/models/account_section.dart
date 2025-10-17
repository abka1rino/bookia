



import 'package:bookia/core/routes/routes.dart';

class AccountSectionModel {
  final String title;
  final String? route;
  AccountSectionModel({required this.title, this.route});
}

List<AccountSectionModel> accountSections = [
  AccountSectionModel(title: 'My Orders',),
  AccountSectionModel(title: 'Edit Profile',route: Routes.editProfile),
  AccountSectionModel(
    title: 'Update Password',
    route: Routes.updatePassword,
  ),
  AccountSectionModel(title: 'Faq', ),
  AccountSectionModel(title: 'Contact Us',),
  AccountSectionModel(title: 'Privacy & Terms',),
];
