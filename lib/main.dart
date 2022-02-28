import 'package:conta_ponto/constants.dart';
import 'package:flutter/material.dart';
import 'package:conta_ponto/screens/main_page_mobile.dart';

void main() => runApp(const ContaPonto());

class ContaPonto extends StatelessWidget {
  const ContaPonto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: UITextStrings.appName,
      theme: appTheme,
      initialRoute:
          '/', //TODO detect between desktop and mobile and load the appropriate screen
      routes: {
        '/': (context) => const MainPageMobile(),
      },
    );
  }
}
