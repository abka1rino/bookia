import 'package:bookia/core/routes/navigation.dart';
import 'package:flutter/material.dart';

class AppBarBackSpace extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBackSpace({super.key, this.action});
  final Widget? action;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            pop(context);
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffE8ECF4), width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: action ?? SizedBox(),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
