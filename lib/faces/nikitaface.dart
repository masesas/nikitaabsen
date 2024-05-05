
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NikitaFace extends StatefulWidget {
  WebViewController? controller;
  NikitaFace({Key? key, this.controller}) : super(key: key);



  State<NikitaFace> createState() => _NikitaFace();


}

class _NikitaFace extends State<NikitaFace> {
  late final WebViewController _controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }else if (request.url.startsWith('http://www.nikita.com/img1')) {
              return NavigationDecision.prevent;
            }else if (request.url.startsWith('http://www.nikita.com/img2')) {
              return NavigationDecision.prevent;
            }else if (request.url.startsWith('file:///ssd')) {
              return NavigationDecision.prevent;

            }
            return NavigationDecision.navigate;
          },
        ),
      )

       ..addJavaScriptChannel(
        'Result',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..addJavaScriptChannel(
        'Start',
        onMessageReceived: (JavaScriptMessage message) async {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
          ByteData bytes = await rootBundle.load('assets/images/re1.png');
         var buffer = bytes.buffer;


          final String contentBase64 = base64Encode(Uint8List.view(buffer) );
          _controller.runJavaScriptReturningResult("  loadRef64('data:image/png;base64,$contentBase64' );");
         // _controller.runJavaScriptReturningResult("  loadQuery64('data:image/png;base64,$contentBase64'v);");

         // _controller.runJavaScriptReturningResult("  load64('data:image/png;base64,$contentBase64','data:image/png;base64,$contentBase64');");
          },
      )

     ..loadRequest(Uri.parse('http://202.56.171.21:2096/face_recognition'));
    //..loadFlutterAsset('assets/images/face.html');
    widget.controller=_controller;
  }

  Widget build(BuildContext context) {
    return  WebViewWidget(controller: _controller);
  }
}
