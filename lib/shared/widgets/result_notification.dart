import 'package:flutter/material.dart';

class ResultNotification extends StatelessWidget {
  final bool isSuccess;
  final String title;
  final String message;
  final Widget? action;

  const ResultNotification({
    super.key,
    required this.isSuccess,
    required this.title,
    required this.message,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              isSuccess ? Icons.check_circle : Icons.cancel,
              size: 60,
              color: isSuccess ? Colors.green : Colors.amber,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.fade,
                    ),
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                    ),
                    maxLines: 4,
                  ),
                ),
              ),
            ],
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}
