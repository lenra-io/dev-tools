import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/lenra_ui_controller.dart';
import 'package:fr_lenra_client/models/dev_tools_socket_model.dart';
import 'package:fr_lenra_client/models/socket_model.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(DevTools());
}

class DevTools extends StatelessWidget {
  static final String appName = "test";

  @override
  Widget build(BuildContext context) {
    var themeData = LenraThemeData();

    return ChangeNotifierProvider<SocketModel>(
      create: (context) => DevToolsSocketModel(),
      builder: (BuildContext context, _) => LenraTheme(
        themeData: themeData,
        child: MaterialApp(
          title: 'DevTool',
          theme: ThemeData(
            textTheme: TextTheme(bodyText2: themeData.lenraTextThemeData.bodyText),
          ),
          home: LenraUiController(appName),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:fr_lenra_client/lenra_application/lenra_ui_controller.dart';
import 'package:fr_lenra_client/models/dev_tools_socket_model.dart';
import 'package:fr_lenra_client/models/socket_model.dart';
import 'package:lenra_components/lenra_components.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(DevTools());
}

class DevTools extends StatelessWidget {
  static final String appName = "test";

  @override
  Widget build(BuildContext context) {
    var themeData = LenraThemeData();

    return ChangeNotifierProvider<SocketModel>(
      create: (context) => DevToolsSocketModel(),
      builder: (BuildContext context, _) => LenraTheme(
        themeData: themeData,
        child: MaterialApp(
          title: 'DevTool',
          theme: ThemeData(
            textTheme: TextTheme(bodyText2: themeData.lenraTextThemeData.bodyText),
          ),
          home: LenraUiController(appName),
        ),
      ),
    );
  }
}
