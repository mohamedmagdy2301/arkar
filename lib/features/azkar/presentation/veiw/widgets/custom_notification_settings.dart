import 'package:azkar/core/theming/cubit_cahnge_themeing.dart';
import 'package:azkar/core/widgets/snackbar_helper.dart';
import 'package:azkar/features/azkar/presentation/view_model/notification_manager/azkar_notification_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNotificationSettings extends StatelessWidget {
  const CustomNotificationSettings({
    super.key,
    required this.azkarNotificationCubit,
  });
  final AzkarNotificationCubit azkarNotificationCubit;

  @override
  Widget build(BuildContext context) {
    final isLightTheme = context.watch<ThemeCubit>().state != ThemeMode.light;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 80.h,
          width: double.infinity,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "التنبيهات ",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLightTheme
                      ? const Color.fromARGB(255, 48, 48, 48)
                      : const Color.fromARGB(255, 218, 218, 218),
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 153, 153, 153),
                      width: 0.5,
                    ),
                  ),
                  elevation: 0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                  ),
                ),
                onPressed: () async {
                  await azkarNotificationCubit.onTimeChanged(context);
                },
                child: Text(
                  azkarNotificationCubit.textButton,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              CupertinoSwitch(
                // activeColor: const Color.fromARGB(255, 90, 123, 8),
                // trackColor: const Color.fromARGB(255, 156, 214, 9),
                value: azkarNotificationCubit.isSwitchEnable,
                onChanged: (value) {
                  if (azkarNotificationCubit.isSwitchEnable) {
                    azkarNotificationCubit.cancelNotification();
                    showMessage(
                      context,
                      type: SnackBarType.warning,
                      message:
                          'تم الغاء تفعيل اشعارات ${azkarNotificationCubit.azkarScreenBodyItemModel.title}',
                    );
                  } else {
                    showMessage(
                      context,
                      type: SnackBarType.error,
                      message:
                          'اختار الوقت الذي تريد تفعيل اشعارات ${azkarNotificationCubit.azkarScreenBodyItemModel.title}',
                    );
                  }
                },
              ),
            ],
          ),
        ),
        const Divider(
          color: Color.fromARGB(255, 186, 186, 186),
          thickness: .5,
          height: .5,
        )
      ],
    );
  }
}
