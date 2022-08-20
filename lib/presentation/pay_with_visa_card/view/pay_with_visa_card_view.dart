import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/resources/routes_manger.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayWithVisaCardView extends StatefulWidget {
  const PayWithVisaCardView({Key? key}) : super(key: key);

  @override
  State<PayWithVisaCardView> createState() => _PayWithVisaCardViewState();
}

class _PayWithVisaCardViewState extends State<PayWithVisaCardView> {
  late final String token;

  @override
  void initState() {
    if (Get.arguments != null) {
      token = Get.arguments['token'];
    }
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    if (Platform.isIOS) WebView.platform = CupertinoWebView();

    super.initState();
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            Get.offNamed(Routes.homeRoute);
          }),
        ),
        body: WebView(
          initialUrl:
              'https://accept.paymob.com/api/acceptance/iframes/376568?payment_token=$token',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
          backgroundColor: const Color(0x00000000),
        ));
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
