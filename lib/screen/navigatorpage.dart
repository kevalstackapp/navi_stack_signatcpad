import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:navigatr_stack/screen/detailroute.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class NavigatorPage extends StatefulWidget {
  NavigatorPage({this.child});

  final Widget? child;

  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                color: Colors.grey[300],
                child: Image.memory(bytes!.buffer.asUint8List()),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Navigator(
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return Scaffold(
                  appBar: AppBar(
                    title: Text("Navigation Stack"),
                    centerTitle: true,
                  ),
                  body: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return DetailRoute(
                                    textEditingController:
                                        _textEditingController,
                                  );
                                },
                              ),
                            );
                          },
                          child: Text("Next Scrren")),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        color: Colors.red.shade200,
                        height: 100,
                        child: SfSignaturePad(
                          key: signatureGlobalKey,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          TextButton(
                            child: Text('ToImage'),
                            onPressed: _handleSaveButtonPressed,
                          ),
                          TextButton(
                            child: Text('Clear'),
                            onPressed: _handleClearButtonPressed,
                          )
                        ],
                      )
                    ],
                  ));
            },
          );
        },
      ),
      onWillPop: () {
        return Future.value(false);
      },
    );
  }
}
