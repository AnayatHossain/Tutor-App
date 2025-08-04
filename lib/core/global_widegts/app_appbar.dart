import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../const/icons_path.dart';
import '../const/image_path.dart';

class AppAppbar extends StatelessWidget {
  final bool isSearch;

  const AppAppbar({super.key, this.isSearch = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(ImagePath.authImage, width: 40),
        const Spacer(),
        if (isSearch)
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFFEDF7EE),
            child: InkWell(
              onTap: () {
               // Get.to(() => SearchView());
              },
              child: Image.asset(IconsPath.searchIcon),
            ),
          ),
        if (isSearch) const SizedBox(width: 10),
        InkWell(
          onTap: () {
           // Get.to(() => UserListScreen());
          },
          child: CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFFEDF7EE),
            child: Image.asset(IconsPath.messageIcon),
          ),
        ),
      ],
    );
  }
}
