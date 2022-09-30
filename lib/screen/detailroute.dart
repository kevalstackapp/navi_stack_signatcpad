import 'package:flutter/material.dart';
import 'package:navigatr_stack/screen/navigatorpage.dart';
import 'package:navigatr_stack/screen/newpage.dart';

class DetailRoute extends StatelessWidget {
  DetailRoute({this.textEditingController, this.index});

  final TextEditingController? textEditingController;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => goback(context),
        child: Scaffold(
            appBar: AppBar(
              title: Text('Route for $index Item'),
            ),
            body: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return newpage();
                    },
                  ));
                },
                child: Text("next page "))));
  }

  Future<bool> goback(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return NavigatorPage();
      },
    ));

    return Future.value();
  }
}
