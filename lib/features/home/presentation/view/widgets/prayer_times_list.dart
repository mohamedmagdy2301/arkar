import 'dart:async';

import 'package:azkar/core/functions/get_status_prayer_name.dart';
import 'package:azkar/core/theming/cubit_cahnge_themeing.dart';
import 'package:azkar/core/utils/colors.dart';
import 'package:azkar/core/utils/strings.dart';
import 'package:azkar/features/home/data/models/prayer_time_model.dart';
import 'package:azkar/features/home/domain/prayer_times_entity.dart';
import 'package:azkar/features/home/presentation/view/widgets/prayer_time_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerTimesList extends StatefulWidget {
  const PrayerTimesList({super.key, required this.prayerTimes});
  final List<PrayerTimesEntity> prayerTimes;

  @override
  State<PrayerTimesList> createState() => _PrayerTimesListState();
}

class _PrayerTimesListState extends State<PrayerTimesList> {
  List<PrayerTimeModel> prayerModels = [];

  List nextPrayerTime = findPrayerNames()['nextPrayer']!;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializePrayerModels();
    _startTimer();
  }

  void _initializePrayerModels() {
    final times = widget.prayerTimes[0];
    prayerModels = [
      PrayerTimeModel(
        nameEn: "Fajr",
        nameAr: StringsAppAR.alFajr,
        time: times.fajrTime,
      ),
      PrayerTimeModel(
        nameEn: "Sunrise",
        nameAr: StringsAppAR.alShoroq,
        time: times.sunriseTime,
      ),
      PrayerTimeModel(
        nameEn: "Dhuhr",
        nameAr: StringsAppAR.alZaher,
        time: times.dhuhrTime,
      ),
      PrayerTimeModel(
        nameEn: "Asr",
        nameAr: StringsAppAR.alAsr,
        time: times.asrTime,
      ),
      PrayerTimeModel(
        nameEn: "Maghrib",
        nameAr: StringsAppAR.alMagreb,
        time: times.maghribTime,
      ),
      PrayerTimeModel(
        nameEn: "Isha",
        nameAr: StringsAppAR.alEsha,
        time: times.ishaTime,
      ),
    ];
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        nextPrayerTime = findPrayerNames()['nextPrayer']!;
      });
    });
  }

  Color _updatePrayerTimeColor(prayerName, isLightTheme) {
    for (var prayer in nextPrayerTime) {
      if (prayer == prayerName) {
        if (nextPrayerTime[0] == prayerName) {
          return ColorsAppLight.primaryColor;
        }
        return isLightTheme ? Colors.black : Colors.white;
      }
    }
    return Colors.grey;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = context.watch<ThemeCubit>().state == ThemeMode.light;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: ListView.builder(
            itemCount: prayerModels.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final model = prayerModels[index];
              return Column(
                children: [
                  PrayerTimeRow(
                    title: model.nameAr,
                    time: model.time,
                    colorText: _updatePrayerTimeColor(
                      model.nameEn,
                      isLightTheme,
                    ),
                  ),
                  const Divider(thickness: .3, height: 0),
                ],
              );
            }),
      ),
    );
  }
}
