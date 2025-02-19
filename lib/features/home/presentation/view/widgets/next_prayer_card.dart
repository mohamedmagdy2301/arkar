import 'package:azkar/core/utils/colors.dart';
import 'package:azkar/features/home/domain/prayer_times_entity.dart';
import 'package:azkar/features/home/presentation/view_model/next_prayer/next_prayer_cubit.dart';
import 'package:azkar/features/home/presentation/view_model/next_prayer/next_prayer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextPrayerCard extends StatelessWidget {
  const NextPrayerCard({
    super.key,
    required this.prayerTimes,
    required this.locationName,
  });
  final List<PrayerTimesEntity> prayerTimes;
  final String locationName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NextPrayerCubit(prayerTimes: prayerTimes),
      child: BlocBuilder<NextPrayerCubit, NextPrayerState>(
        builder: (context, state) {
          return Container(
            height: 140.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorsAppLight.primaryColor.withAlpha(150),
                  ColorsAppLight.primaryColor.withAlpha(200),
                  ColorsAppLight.primaryColor.withAlpha(250),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.7, 1],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 18.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    Text(
                      locationName,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'متبقي علي',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'صلاة ${state.nextPrayerName}',
                          style: TextStyle(
                            fontSize: 25.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          state.remainingTime,
                          style: TextStyle(
                            fontSize: 26.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          'ساعة',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
