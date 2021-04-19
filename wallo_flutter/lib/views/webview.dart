import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class Webview extends StatefulWidget {
  const Webview({Key key, this.url, this.onLoginSuccess, this.isLoading})
      : super(key: key);
  final String url;
  final bool isLoading;
  final Function(String) onLoginSuccess;

  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          userAgent: "wallo",
          initialUrl: 'https://wall-o.herokuapp.com/users/auth/google',
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith(
                'https://wall-o.herokuapp.com/users/auth/google/callback')) {
              print('blocking navigation to $request}');
              widget.onLoginSuccess(request.url);
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        ),
        if (_isLoading == true || widget.isLoading == true)
          Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              )),
      ],
    );
  }
}
