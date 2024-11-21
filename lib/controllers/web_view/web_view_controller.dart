import 'package:get/get.dart';

class WebViewController extends GetxController {
  var isLoading = true.obs;
  var isError = false.obs;

  void onLoadStart() {
    isLoading.value = true;
    isError.value = false;
  }

  void onLoadEnd() {
    isLoading.value = false;
  }

  void onError() {
    isLoading.value = false;
    isError.value = true;
  }
}
