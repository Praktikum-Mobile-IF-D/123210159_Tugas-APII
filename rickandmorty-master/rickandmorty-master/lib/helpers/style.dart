import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Style {
  static InputDecoration getInputDecoration({icons, hintText}) {
    return InputDecoration(
      prefixIcon: icons,
      hintText: hintText,
      label: Text(hintText),
    );
  }

  static ButtonStyle getButtonStyle() {
    return ElevatedButton.styleFrom(
      elevation: 8.0,
      shadowColor: Colors.blue[900],
      backgroundColor: Colors.blue,
      disabledBackgroundColor: Colors.white.withOpacity(0.4),
      disabledForegroundColor: Colors.grey,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      textStyle: const TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }

    static getCustomToast(
      {context, text, ToastificationType type = ToastificationType.success}) {
    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flatColored,
      title: Text(text),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}
