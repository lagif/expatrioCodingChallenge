import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AppBottomSheet {
  static void show({
    required BuildContext context,
    required Widget child,
    VoidCallback? onComplete,
  }) async {
    await showMaterialModalBottomSheet<void>(
      isDismissible: true,
      expand: false,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.white,
      clipBehavior: Clip.none,
      builder: (context) => SafeArea(
        top: false,
        bottom: true,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            controller: ModalScrollController.of(context),
            child: child,
          ),
        ),
      ),
    );
    onComplete?.call();
  }
}
