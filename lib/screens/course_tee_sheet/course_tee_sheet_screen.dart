import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:goat_flutter/controllers/web_view/web_view_controller.dart';
import 'package:goat_flutter/widgets/custom_back_button.dart';
import '../../config/app_config.dart';

class CourseTeeSheetScreen extends StatelessWidget {
  final String url;

  const CourseTeeSheetScreen({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    final webViewController = Get.put(WebViewController());

    return Scaffold(
      appBar: AppBar(
        leading: const Hero(
            tag: 'bookTeeTime',
            child: CustomBackButton()),
        title: const Text('Course Tee Sheet',style: TextStyle(
            fontSize: AppConfig.headingFontSize,
            fontStyle: FontStyle.italic
        ),),
      ),
      body: Obx(() {
        if (webViewController.isError.value) {
          return Center(
            child: Text(
              'Please try again later',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 18,
              ),
            ),
          );
        }

        return Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(url)),
              onLoadStart: (controller, _) {
                webViewController.onLoadStart();
              },
              onLoadStop: (controller, _) {
                webViewController.onLoadEnd();
              },
              onReceivedError: (controller, request, error) {
              },
              onReceivedHttpError: (controller, request, response) {
              },
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
              ),
            ),
            // if (webViewController.isLoading.value)
            //   Center(
            //     child: Lottie.asset('assets/lottie/loading.json'),
            //   ),
          ],
        );
      }),
    );
  }
}
