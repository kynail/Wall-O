import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wallo_flutter/redux/store.dart';
import 'package:wallo_flutter/redux/user/user_state.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wallo_flutter/redux/user/user_actions.dart';
import 'dart:io';
import 'dart:async';

class Webview extends StatefulWidget {
  const Webview({Key key, this.url}) : super(key: key);
  final String url;

  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserState>(
        distinct: true,
        converter: (store) => store.state.userState,
        builder: (context, userState) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text("hello"),
            ),
            body: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              userAgent: "wallo",
              initialUrl: 'http://192.168.1.6:4000/users/auth/google',
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith(
                    'http://192.168.1.6:4000/users/auth/google/callback')) {
                  print('blocking navigation to $request}');

                  Redux.store
                      .dispatch((store) => logUserGoogle(store, request.url));
                  return NavigationDecision.prevent;
                }
                // print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
              gestureNavigationEnabled: true,
            ),
          );
        });
  }
}
