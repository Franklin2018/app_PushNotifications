import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajeStreamController = StreamController<String>.broadcast();

  Stream<String> get mensajesStream => _mensajeStreamController.stream;

  static Future<dynamic> onBackgroundMessage(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message

      final dynamic notification = message['notification'];
    }
  }

  initNotifications() async {
    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();

    print('=======FCM token ============');
    print(token);
    //fy7yKmYzQQGZ_lVs5-w8yZ:APA91bH7JL6p05C1TUqpSOglt4PUHWmvouLV5X5aJSYT371q_HEkOjozNRitSxhdBlFG48dJa3m6s4cS_ZOtwxiRWD6tGszn5EFErnuOItYc386y98g4bu9-NTqPPTdlSI9rMHIZeSih

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: PushNotificationsProvider.onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume,
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    final mensaje = message['data']['mensaje'] ?? 'no-data';
    _mensajeStreamController.sink.add(mensaje);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    final mensaje = message['data']['mensaje'] ?? 'no-data';
    _mensajeStreamController.sink.add(mensaje);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    final mensaje = message['data']['mensaje'] ?? 'no-data';
    _mensajeStreamController.sink.add(mensaje);
  }

  dispose() {
    _mensajeStreamController?.close();
  }
}
