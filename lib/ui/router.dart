import 'package:flutter/material.dart';
import 'package:srvad_app/core/constants/app_constants.dart';
import 'package:srvad_app/ui/screen/login_page.dart';

const String initialRoute = "/";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
/*      case RoutePaths.Landing:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => MyHomePage());*/
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      /*case RoutePaths.SignIn:
        return MaterialPageRoute(builder: (_) => SignInPage());
      case RoutePaths.Post:
        var post = settings.arguments as Post;
        return MaterialPageRoute(builder: (_) => PostView(post: post));
      case RoutePaths.PostListItem:
        return MaterialPageRoute(builder: (_) => PostListItem());*/
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}