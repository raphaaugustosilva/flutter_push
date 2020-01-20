import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_push/services/pushNotificationFCMService.dart';

class PrincipalView extends StatefulWidget {
  @override
  _PrincipalViewState createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String token;
  String ultimoPushRecebido;
  PushNotificationFCMService pushNotificationFCMService;

  @override
  void initState() {
    pushNotificationFCMService = PushNotificationFCMService(aoRegistrarDevice, aoReceberPush);
    pushNotificationFCMService.setUpFirebase();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("POC Push Notification"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text("Forçar registrar device"),
                onPressed: () {
                  pushNotificationFCMService.setUpFirebase();
                }),
            Text("Token:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(token ?? ""),
            SizedBox(height: 40),
            Text("Último push recebido:", style: TextStyle(fontWeight: FontWeight.bold)),
            Column(
              children: <Widget>[
                Text("${ultimoPushRecebido ?? ""}", maxLines: null),
              ],
            )
          ],
        ),
      ),
    );
  }

  void aoRegistrarDevice(String tokenRegistrado) {
    Clipboard.setData(new ClipboardData(text: token ?? ""));
    _scaffoldKey.currentState.showSnackBar(SnackBar(backgroundColor: Colors.blue, content: Text("Token copiado !")));
    setState(() => token = tokenRegistrado);
  }

  void aoReceberPush(Map<String, dynamic> pushRecebido) {
    setState(() {
      ultimoPushRecebido = "";
      for (dynamic key in pushRecebido.keys) {
        ultimoPushRecebido += "${key.toString()} -> ${pushRecebido[key]} \n";

        // if (pushRecebido[key] is Map) {
        //   ultimoPushRecebido += "\n\n";
        //   for (dynamic keyInside in pushRecebido[key].keys) {
        //     ultimoPushRecebido += "    - ${pushRecebido[key][keyInside].toString()} \n";
        //   }
        // }
      }
    });
  }
}
