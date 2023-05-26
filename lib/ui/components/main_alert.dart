import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainAlertNotification extends StatelessWidget {
  final String title;
  final String message;
  final bool hasElevation;
  final bool showCloseButton;
  final bool iconTopLeft;
  final Function()? onCloseButtonTap;

  const MainAlertNotification({
    Key? key,
    this.title = '',
    this.message = '',
    this.showCloseButton = false,
    this.hasElevation = false,
    this.iconTopLeft = true,
    this.onCloseButtonTap,
  }) : super(key: key);

  static void show(
    BuildContext context, {
    String title = '',
    String message = '',
    Duration duration = const Duration(seconds: 2),
  }) {
    FToast().init(context).showToast(
          gravity: ToastGravity.BOTTOM,
          toastDuration: duration,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: MainAlertNotification(
                  showCloseButton: true,
                  title: title,
                  message: message,
                  onCloseButtonTap: () {
                    FToast().removeCustomToast();
                  },
                ),
              ),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.red.shade300,
          width: 1,
        ),
        boxShadow: [
          if (hasElevation)
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
        ],
      ),
      child: Stack(
        children: [
          if (iconTopLeft)
            Align(
              alignment: Alignment.topLeft,
              child: Icon(
                Icons.warning_amber_outlined,
                color: Colors.red.shade300,
              ),
            ),
          if (showCloseButton)
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
                onPressed: onCloseButtonTap,
              ),
            ),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(horizontal: iconTopLeft ? 30 : 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (title.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (!iconTopLeft)
                        const Padding(
                          padding: EdgeInsets.only(
                            right: 15,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.warning_amber_outlined,
                            ),
                          ),
                        ),
                      Expanded(
                        child: Text(
                          title,
                          style: theme.primaryTextTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                if (title.isNotEmpty && message.isNotEmpty)
                  const SizedBox(height: 20),
                if (message.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(message),
                      ),
                    ],
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
