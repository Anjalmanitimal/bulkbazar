import 'dart:async';
import 'package:proximity_sensor/proximity_sensor.dart';

class ProximityService {
  StreamSubscription? _subscription;

  void startListening(Function(bool) onDetected) {
    _subscription = ProximitySensor.events.listen((event) {
      if (event > 0) {
        onDetected(true);
      } else {
        onDetected(false);
      }
    });
  }

  void stopListening() {
    _subscription?.cancel();
  }
}
