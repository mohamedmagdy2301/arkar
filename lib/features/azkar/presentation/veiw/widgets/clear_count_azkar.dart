import 'package:azkar/features/azkar/presentation/view_model/view_azkar/azkar_details_cubit.dart';
import 'package:azkar/features/azkar/presentation/view_model/view_azkar/azkar_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClearCountAzkarWidget extends StatelessWidget {
  const ClearCountAzkarWidget({super.key, required this.state});
  final AzkarDetailsState state;
  bool isComplete() {
    for (int i = 0; i < state.dataList!.length; i++) {
      if (state.counters[i] != int.parse(state.dataList?[i]["count"] ?? "0")) {
        return false;
      }
    }
    return true;
  }

  bool isShowClearIcon() {
    for (int i = 0; i < state.dataList!.length; i++) {
      if (state.counters[i] != 0) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return isShowClearIcon()
        ? IconButton(
            onPressed: () {
              for (int i = 0; i < state.dataList!.length; i++) {
                context.read<AzkarDetailsCubit>().clearCounters();
              }
            },
            icon: Icon(Icons.refresh,
                color: isComplete() ? Colors.black : Colors.grey),
            tooltip: 'اعادة تعيين العداد',
          )
        : SizedBox();
  }
}
