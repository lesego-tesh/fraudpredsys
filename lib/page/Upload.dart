import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(
        //     // title: const Text('webpage'),
        //     //centerTitle: true,
        //     // backgroundColor: Colors.blue,
        //     ),
        body: loadBody(),
      );

  Widget loadBody() {
    return Builder(builder: (BuildContext context) {
      return WebView(
        initialUrl: 'http://5243-168-167-93-8.ngrok.io/upload_credit_data/', //
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          if (kDebugMode) {
            print('WebView is loading (progress : $progress%)');
          }
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        onPageStarted: (String url) {
          if (kDebugMode) {
            print('Page started loading: $url');
          }
        },
        onPageFinished: (String url) {
          if (kDebugMode) {
            print('Page finished loading: $url');
          }
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      );
    });
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
