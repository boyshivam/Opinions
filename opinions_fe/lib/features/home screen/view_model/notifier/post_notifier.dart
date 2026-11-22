import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";


class PostNotifier extends Notifier <dynamic> {

  @override
  String build() {
    return "";
  }

  String selectEditButton() {
    return "edit";
  }

  String selectedDeleteButton() {
    return "delete";
  }



}