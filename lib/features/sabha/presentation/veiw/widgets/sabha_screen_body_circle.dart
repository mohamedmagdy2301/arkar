import 'package:azkar/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SabhaScreenBodyCircle extends StatelessWidget {
  const SabhaScreenBodyCircle({
    super.key,
    required this.counter,
    required this.selectedSabha,
  });

  final String selectedSabha;
  final int counter;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: 300.w,
      decoration: BoxDecoration(
        color: ColorsAppLight.primaryColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(141, 98, 131, 8),
            blurRadius: 12,
            spreadRadius: 8,
          ),
        ],
        // boxShadow: [
        //   BoxShadow(
        //     color: ColorsAppLight.primaryColor,
        //     blurRadius: 25.sp,
        //     spreadRadius: 15.sp,
        //   ),
        // ],
        // gradient: const LinearGradient(
        //   colors: [
        //     Color.fromARGB(255, 162, 191, 89),
        //     Color.fromARGB(255, 165, 187, 110),
        //     ColorsAppLight.primaryColor,
        //     Color.fromARGB(255, 110, 125, 73),
        //     Color.fromARGB(255, 97, 110, 65),
        //   ],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            counter.toString(),
            maxLines: 1,
            style: TextStyle(
              fontSize: 100.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "Amiri",
            ),
          ),
          Text(
            selectedSabha,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40.sp,
              color: Colors.white,
              fontFamily: "Amiri",
            ),
          ),
        ],
      ),
    );
  }
}
