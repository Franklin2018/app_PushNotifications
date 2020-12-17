import 'package:app_notifications/src/providers/push_notification_provider.dart';
import 'package:flutter/material.dart';

import 'package:app_notifications/src/pages/home_page.dart';
import 'package:app_notifications/src/pages/mensaje_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationsProvider();
    pushProvider.initNotifications();

    pushProvider.mensajesStream.listen((data) {
      navigatorKey.currentState.pushNamed('mensaje', arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Notifications App',
        initialRoute: 'home',
        routes: {
          'home': (BuildContext c) => HomePage(),
          'mensaje': (BuildContext c) => MensajePage(),
        });
  }
}
