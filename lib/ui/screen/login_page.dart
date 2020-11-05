import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:srvad_app/core/viewmodels/views/login_view_model.dart';
import 'package:srvad_app/ui/shared/app_colors.dart';
import 'package:srvad_app/ui/shared/ui_helpers.dart';
import 'package:srvad_app/ui/widgets/busy_button.dart';
import 'package:srvad_app/ui/widgets/input_field.dart';

import 'base_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BasePage<LoginViewModel>(
      model: LoginViewModel(),
      builder: (context, model, child) => Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Suivi Prod'),
          ),
          backgroundColor: backgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 150,
                  //child: Image.asset('assets/images/title.png',),
                  child: CachedNetworkImage(
                    imageUrl:
                        "http://suiviprod.urbalyon.org/assets/img/logo-ag.png",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.red[50], BlendMode.colorBurn)),
                      ),
                    ),
                    height: 100,
                    width: 114,
                    filterQuality: FilterQuality.low,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                UIHelper.verticalSpaceSmall,
                InputField(
                  placeholder: 'Email',
                  onSaved: (value) {
                    model.email = value;
                  },
                  controller: emailController,
                ),
                InputField(
                  placeholder: 'Password',
                  onSaved: (value) {
                    model.password = value;
                  },
                  password: true,
                  controller: passwordController,
                ),
                UIHelper.verticalSpaceMedium,
                BusyButton(
                  title: 'Se connecter',
                  busy: model.state,
                  onPressed: () async {
                    var loginSuccess = await model.login();
                    if (loginSuccess != null) {
                      print('login status: $loginSuccess');

                      Navigator.pushNamed(context, 'home');
                    } else {
                      return 'Error for that field';
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
