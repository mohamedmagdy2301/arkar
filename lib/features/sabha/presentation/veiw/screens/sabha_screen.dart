import 'package:azkar/core/local_storage/shared_preferences_manager.dart';
import 'package:azkar/core/utils/colors.dart';
import 'package:azkar/core/utils/strings.dart';
import 'package:azkar/features/sabha/presentation/veiw/widgets/sabha_screen_body_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SabhaScreen extends StatefulWidget {
  const SabhaScreen({super.key});
  static const String routeName = '/sabha';

  @override
  State<SabhaScreen> createState() => _SabhaScreenState();
}

class _SabhaScreenState extends State<SabhaScreen> {
  int counter = SharedPreferencesManager.getData(key: 'counter') ?? 0;
  String selectedSabha = "سبحان الله";
  final List<String> sabhaTypes = [
    "سبحان الله",
    "الحمد لله",
    "الله أكبر",
    "لا إله إلا الله",
    "سبحان الله وبحمده",
    "سبحان الله العظيم",
    "أستغفر الله",
  ];

  void incrementCounter() {
    setState(() {
      counter++;
      SharedPreferencesManager.setData(key: 'counter', value: counter);
    });
  }

  void clearCounter() {
    setState(() {
      counter = 0;
      SharedPreferencesManager.setData(key: 'counter', value: counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: ColorsAppLight.primaryColor.withAlpha(40),
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsAppLight.primaryColor,
                      blurRadius: 3,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  value: selectedSabha,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSabha = newValue!;
                      clearCounter();
                    });
                  },
                  items:
                      sabhaTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    );
                  }).toList(),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                    size: 33.sp,
                  ),
                  dropdownColor: ColorsAppLight.primaryColor,
                  elevation: 2,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => incrementCounter(),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 50.h),
                child: SabhaScreenBodyCircle(
                  counter: counter,
                  selectedSabha: selectedSabha,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        StringsAppAR.sabha,
        style: TextStyle(
          fontSize: 36.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(),
      elevation: 4,
      toolbarHeight: 60.h,
      backgroundColor: ColorsAppLight.primaryColor,
      actions: [
        counter != 0
            ? IconButton(
                onPressed: () => clearCounter(),
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 30.sp,
                ),
                tooltip: 'اعادة تعيين العداد',
              )
            : SizedBox()
      ],
    );
  }
}
