import 'package:azkar/core/utils/strings.dart';
import 'package:azkar/features/azkar/data/azkar_screen_body_item_model_data.dart';
import 'package:azkar/features/azkar/presentation/veiw/screens/azkar_details_screen.dart';
import 'package:azkar/features/azkar/presentation/veiw/widgets/azkar_screen_body_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class AzkarScreenBody extends StatelessWidget {
  const AzkarScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AzkarScreenBodyItem(
              azkarScreenBodyItemModel: azkarScreenBodyItemModel[0],
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: AzkarDetailsScreen(
                      azkarScreenBodyItemModel: azkarScreenBodyItemModel[0]),
                );
              },
            ),
            AzkarScreenBodyItem(
              azkarScreenBodyItemModel: azkarScreenBodyItemModel[1],
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: AzkarDetailsScreen(
                      azkarScreenBodyItemModel: azkarScreenBodyItemModel[1]),
                );
              },
            ),
            Text(
              StringsAppAR.azkarMtnwa,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            AzkarScreenBodyItem(
              azkarScreenBodyItemModel: azkarScreenBodyItemModel[2],
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: AzkarDetailsScreen(
                      azkarScreenBodyItemModel: azkarScreenBodyItemModel[2]),
                );
              },
            ),
            AzkarScreenBodyItem(
              azkarScreenBodyItemModel: azkarScreenBodyItemModel[3],
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: AzkarDetailsScreen(
                      azkarScreenBodyItemModel: azkarScreenBodyItemModel[3]),
                );
              },
            ),
            AzkarScreenBodyItem(
              azkarScreenBodyItemModel: azkarScreenBodyItemModel[4],
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: AzkarDetailsScreen(
                      azkarScreenBodyItemModel: azkarScreenBodyItemModel[4]),
                );
              },
            ),
            AzkarScreenBodyItem(
              azkarScreenBodyItemModel: azkarScreenBodyItemModel[5],
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: AzkarDetailsScreen(
                      azkarScreenBodyItemModel: azkarScreenBodyItemModel[5]),
                );
              },
            ),
            AzkarScreenBodyItem(
              azkarScreenBodyItemModel: azkarScreenBodyItemModel[6],
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: AzkarDetailsScreen(
                      azkarScreenBodyItemModel: azkarScreenBodyItemModel[6]),
                );
              },
            ),
            AzkarScreenBodyItem(
              azkarScreenBodyItemModel: azkarScreenBodyItemModel[7],
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: AzkarDetailsScreen(
                      azkarScreenBodyItemModel: azkarScreenBodyItemModel[7]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
