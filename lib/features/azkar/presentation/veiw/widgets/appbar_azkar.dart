import 'package:azkar/core/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarAzkar extends StatelessWidget implements PreferredSizeWidget {
  const AppBarAzkar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        StringsAppAR.appName,
        style: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.w800,
          fontFamily: "Amiri",
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(),
      elevation: 0,
      toolbarHeight: 90.h,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90.h);
}
