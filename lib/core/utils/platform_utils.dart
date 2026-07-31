import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';

void hapticTap() => HapticFeedback.lightImpact();
void hapticSelection() => HapticFeedback.selectionClick();
void hapticMedium() => HapticFeedback.mediumImpact();

void dismissKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

Widget platformLoader({double size = 24}) {
  if (Platform.isIOS) {
    return const CupertinoActivityIndicator();
  }
  return SizedBox(
    width: size,
    height: size,
    child: const CircularProgressIndicator(
      strokeWidth: 2.5,
      color: VrTheme.purple,
    ),
  );
}
