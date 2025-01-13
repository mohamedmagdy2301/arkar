import 'dart:async'; // Import the async package

import 'package:azkar/features/home/data/repo/prayer_time_repo_impl.dart';
import 'package:azkar/features/home/domain/prayer_times_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

part 'prayper_times_state.dart';
//   https://api.aladhan.com/v1/timings?latitude=30.5632921&longitude=30.9970544&method=5

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  PrayerTimesCubit() : super(PrayerTimesInitial()) {
    _scheduleDailyFetch();
  }

  PrayerTimesRepository prayerTimesRepository = PrayerTimesRepository();
  List<PrayerTimesEntity> prayerTimes = [];
  Timer? _timer; // Timer variable

  Future<void> fetchPrayerTimes() async {
    emit(PrayerTimesLoading());
    try {
      final position = await _determinePosition();
      final locationName = await _getLocationName(position);

      prayerTimes =
          await prayerTimesRepository.fetchPrayerTimes(location: position);
      emit(PrayerTimesLoaded(prayerTimes, locationName));
    } catch (e) {
      emit(PrayerTimesError(e.toString()));
    }
  }

  void _scheduleDailyFetch() {
    // Calculate the duration until the next midnight
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = nextMidnight.difference(now);

    // Schedule the timer
    _timer = Timer(durationUntilMidnight, () {
      fetchPrayerTimes(); // Fetch prayer times at midnight
      _scheduleDailyFetch(); // Reschedule for the next day
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Cancel the timer when closing
    return super.close();
  }

  Future<String> _getLocationName(Position position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return '${place.locality}, ${place.country}';
      }
      return 'Unknown Location';
    } catch (e) {
      return 'Unknown Location';
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
