import 'package:flutter/material.dart';
import 'package:flutter_push/helpers/navegacaoHelper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "POC Flutter Push",
      //theme: TemaApp.temaPrincipalApp(context),
      //initialRoute: NavegacaoHelper.rotaCarregaDadosInicias,
      onGenerateRoute: NavegacaoHelper.rotas(),
      onUnknownRoute: NavegacaoHelper.rotaNaoEncontrada(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt'),
        const Locale('en'),
      ],
    );
  }
}