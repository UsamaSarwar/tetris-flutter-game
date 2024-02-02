import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tetris/gamer/gamer.dart';
import 'package:tetris/generated/l10n.dart';
import 'package:tetris/material/audios.dart';
import 'package:tetris/panel/page_portrait.dart';

import 'gamer/keyboard.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  _disableDebugPrint();
  runApp(const MyApp());
}

const BACKGROUND_COLOR = Color(0xffefcc19);

const SCREEN_BORDER_WIDTH = 3.0;

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

void _disableDebugPrint() {
  bool debug = false;
  assert(() {
    debug = true;
    return true;
  }());
  if (!debug) {
    debugPrint = (message, {wrapWidth}) {
      //disable log print when not in debug mode
    };
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tetris',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      navigatorObservers: [routeObserver],
      supportedLocales: S.delegate.supportedLocales,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: Colors.amberAccent,
        // brightness: Brightness.dark, 
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tetris Game'),
          centerTitle: true,
        ),
        body: Sound(child: Game(child: KeyboardController(child: _HomePage()))),
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //only Android/iOS support land mode
    bool land = MediaQuery.of(context).orientation == Orientation.landscape;
    return land ? const PageLand() : const PagePortrait();
  }
}
