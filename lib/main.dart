import 'package:flutter/material.dart';
import 'package:conta_ponto/screens/main_page_mobile.dart';

void main() => runApp(const ContaPonto());

class ContaPonto extends StatelessWidget {
  const ContaPonto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0A0E20),
        scaffoldBackgroundColor: const Color(0xFF0A0E20),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.pink),
        //TODO extract this into a theme file?
      ),
      initialRoute:
          '/', //TODO detect between desktop and mobile and load the appropriate screen
      routes: {
        '/': (context) => const MainPageMobile(),
      },
    );
  }
}
