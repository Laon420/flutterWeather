import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String url =
'https://goo.gl/maps/B7RUhEbCuqVQoifs5';
    return Scaffold(
      appBar: AppBar(
        title: Text('지도'),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
