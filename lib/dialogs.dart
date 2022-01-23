import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

// Usage:
// showLoadingDialog(context)
// Navigator.pop(context)
void showLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withOpacity(0.9),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showErrorDialog(BuildContext context) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
          () async {
        await Future.delayed(const Duration(seconds: 1));
        if (ModalRoute.of(context)?.isCurrent ?? false) {
          Navigator.pop(context);
        }
      }.call();
      return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withOpacity(0.9),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Icon(
                    LucideIcons.xCircle,
                    color: Color(0xFFEB5757),
                    size: 36,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
