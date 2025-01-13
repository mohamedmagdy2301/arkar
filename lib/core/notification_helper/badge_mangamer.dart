// import 'dart:developer';

// import 'package:flutter/services.dart';

// // code in MainActivity =>"android/app/src/main/kotlin/com/example/arkar/MainActivity.kt"

// class BadgeManager {
//   static const platform = MethodChannel('com.example.app/badge');

//   static Future<void> updateBadgeCount(int count) async {
//     try {
//       await platform.invokeMethod('updateBadge', {'count': count});
//     } on PlatformException catch (e) {
//       log("Failed to update badge: '${e.message}'.");
//     }
//   }
// }
