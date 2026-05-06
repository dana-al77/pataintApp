import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class PaymentWebView extends StatefulWidget {
  final String url;
  final String paymentId;
  final Function onFinish;

  const PaymentWebView({
    super.key,
    required this.url,
    required this.paymentId,
    required this.onFinish,
  });

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            print("PAGE: $url");
          },
          onNavigationRequest: (request) {
            if (request.url.contains("callback") ||
                request.url.contains("trigger") ||
                request.url.contains("success")) {

              Get.back(); // اقفل WebView
              widget.onFinish(); // شغّل التحقق
              return NavigationDecision.prevent;
            }


            if (request.url.contains("status=F")) {
              Get.back();
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الدفع")),
      body: WebViewWidget(controller: controller),
    );
  }
}