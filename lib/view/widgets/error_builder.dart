import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorBuilder extends StatelessWidget {
  static bool isDialogShown = false;
  final Widget child;
  final Widget Function(Object exception, StackTrace? stackTrace, BuildContext buildContext) errorBuilder;

  ErrorBuilder({
    required this.child,
    this.errorBuilder = defaultBuilder,
    super.key
  });

  static Widget defaultBuilder(Object exception, StackTrace? stackTrace, BuildContext context) {
    final message = exception.toString();
    debugPrint('$ErrorBuilder caught $message');
    return AlertDialog(
      title: Text('An Error occured'),
      content: Text(message),
    );
  }

  void _showErrorDialog(Object exception, StackTrace? stackTrace, BuildContext context) async {
    if (!isDialogShown) {
      await showDialog<void>(
        context: context,
        builder: (context) {
          isDialogShown = true;
          return errorBuilder(exception, stackTrace, context);
        }
      );
      isDialogShown = false;
    }

  }

  @override
  Widget build(BuildContext context) {
    PlatformDispatcher.instance.onError = (exception, stackTrace) {
      _showErrorDialog(exception, stackTrace, context);
      return true;
    };
    FlutterError.onError = (errorDetails) {
      _showErrorDialog(errorDetails.exception, errorDetails.stack, context);
    };
    return child;
  }
}