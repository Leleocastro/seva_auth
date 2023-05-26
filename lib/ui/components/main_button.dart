import 'package:flutter/material.dart';

class MainButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? color;
  final bool loading;
  const MainButton({
    super.key,
    required this.label,
    this.onPressed,
    this.color,
    this.loading = false,
  });

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: widget.loading ? null : widget.onPressed,
      child: Container(
        width: 250,
        height: 40,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: widget.color ?? theme.primaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Visibility(
            visible: !widget.loading,
            replacement: const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
            child: Text(
              widget.label,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
