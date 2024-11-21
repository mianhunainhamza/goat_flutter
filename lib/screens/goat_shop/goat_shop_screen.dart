import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../config/app_config.dart';
import '../../controllers/web_view/web_view_controller.dart';
import '../../widgets/custom_back_button.dart';

class GoatShopScreen extends StatelessWidget {
  final String url;

  const GoatShopScreen({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    final webViewController = Get.put(WebViewController());

    return Scaffold(
        appBar: AppBar(
          leading: const Hero(tag: 'bookTeeTime', child: CustomBackButton()),
          title: const Text(
            'GOAT Shop',
            style: TextStyle(
                fontSize: AppConfig.headingFontSize,
                fontStyle: FontStyle.italic),
          ),
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(url)),
              onLoadStart: (controller, _) {
                webViewController.onLoadStart();
              },
              onLoadStop: (controller, _) {
                webViewController.onLoadEnd();
              },
              onReceivedError: (controller, request, error) {},
              onReceivedHttpError: (controller, request, response) {},
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
              ),
            ),
            // if (webViewController.isLoading.value)
            //   Center(
            //     child: Lottie.asset('assets/lottie/loading.json'),
            //   ),
          ],
        ));
  }
}
