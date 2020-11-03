
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srvad_app/core/providers/provider_setup.dart';
import 'package:srvad_app/ui/router.dart' as root;

import 'constants/app_constants.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
      // providers: providers,
      return MaterialApp(
        title: 'Test Flutter app',
        theme:ThemeData(primarySwatch: Colors.blue),
        initialRoute: RoutePaths.Login,
        onGenerateRoute: root.Router.generateRoute,
      );
    //   ),
    // );
  }
}