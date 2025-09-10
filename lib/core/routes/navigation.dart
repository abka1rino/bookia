import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

pushTo(BuildContext context, String newPage, {Object? extra}) {
  context.push(newPage, extra: extra);
}

pushWithReplacement(BuildContext context, String newPage, {Object? extra}) {
  context.pushReplacement(newPage, extra: extra);
}

pushUntil(BuildContext context, String newPage, {Object? extra}) {
  context.go(newPage, extra: extra);
}

pop(BuildContext context) {
  context.pop();
}
