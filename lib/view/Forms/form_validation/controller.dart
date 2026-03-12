// ignore_for_file: unnecessary_overrides, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final _status = Rx<RxStatus>(RxStatus.empty());

  RxBool isShow = true.obs;
  RxBool login = true.obs;

  RxStatus get status => _status.value;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    passwordController.dispose();
  }

  bool _isValid() {
    if (nameController.text.trim().isEmpty) {
      return false;
    }
    return true;
  }
}
