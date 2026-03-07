import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerService {
  StreamSubscription? _subscription;

  DateTime _lastShake = DateTime.now();

  void startListening(VoidCallback onShake) {
    _subscription = accelerometerEvents.listen((event) {
      /// CALCULATE TOTAL FORCE
      double gForce =
          (event.x * event.x + event.y * event.y + event.z * event.z);

      /// STRONG SHAKE ONLY
      if (gForce > 150) {
        final now = DateTime.now();

        /// PREVENT MULTIPLE TRIGGERS
        if (now.difference(_lastShake).inSeconds > 3) {
          _lastShake = now;
          onShake();
        }
      }
    });
  }

  void stopListening() {
    _subscription?.cancel();
  }
}
