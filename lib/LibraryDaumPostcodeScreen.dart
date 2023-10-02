
import 'package:daum_postcode_search/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'main.dart';

class LibraryDaumPostcodeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      // MaterialApp(
      // home:
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("다음 주소 검색"), backgroundColor: customGreenAccent,),
        body: DaumPostcodeSearch(
          webPageTitle: "주소 검색",
          initialOption: InAppWebViewGroupOptions(),
          onConsoleMessage: ((controller, consoleMessage) {}),
          onLoadError: ((controller, url, code, message) {}),
          onLoadHttpError: (controller, url, statusCode, description) {},
          onProgressChanged: (controller, progress) {},
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
        ),
      );
    // );
  }
}