import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:navigatr_stack/screen/detailroute.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
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
            appBar: AppBar(title: Text("Your signature")),
            body: Column(
              children: [
                Container(
                  color: Colors.grey[300],
                  child: Image.memory(bytes!.buffer.asUint8List()),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    child: Text("Save As Image"), onPressed: () async {}),
              ],
            ),
          );
        },
      ),
    );
  }

  TextEditingController tname = TextEditingController();

  List<Color> bg = [
    Colors.black,
    Colors.red,
    Colors.yellowAccent,
    Colors.purple,
  ];

  bool stsu = false;
  bool valuechek = false;
  String value = "";

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
                  body: SingleChildScrollView(
                    child: Column(
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
                          height: 100,
                          child: SfSignaturePad(
                            key: signatureGlobalKey,
                            backgroundColor: Colors.white,
                            strokeColor: stsu
                                ? Color((Random().nextDouble() * 0xFFFFFF)
                                        .toInt())
                                    .withOpacity(1.0)
                                : Colors.purple,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              child: Text('ToImage'),
                              onPressed: _handleSaveButtonPressed,
                            ),
                            ElevatedButton(
                              child: Text('Clear'),
                              onPressed: () {
                                setState(() {
                                  signatureGlobalKey.currentState!.clear();
                                  stsu = true;
                                });
                              },
                            )
                          ],
                        ),
                        TextFormField(
                          controller: tname,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                value = tname.text;
                                valuechek = true;
                              });
                            },
                            child: Text("generate your barcode")),
                        Container(
                          height: 100,
                          width: 100,
                          child: SfBarcodeGenerator(
                            value: valuechek ? value : "",
                            symbology: QRCode(),
                            showValue: true,
                          ),
                        ),
                      ],
                    ),
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
