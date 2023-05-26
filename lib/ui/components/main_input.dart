import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seva_auth/utils/state_bloc.dart';

class MainInput extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final bool isPassword;
  final bool isRequired;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const MainInput({
    super.key,
    this.label,
    this.hint,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.isPassword = false,
    this.isRequired = false,
    this.validator,
    this.controller,
  });

  @override
  State<MainInput> createState() => _MainInputState();
}

class _MainInputState extends State<MainInput> {
  final StateBloc<bool> _obscurePassword = StateBloc(false);

  @override
  void initState() {
    _obscurePassword(widget.isPassword);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<StateBloc<bool>, bool>(
        bloc: _obscurePassword,
        builder: (context, state) {
          return TextFormField(
            controller: widget.controller,
            cursorColor: theme.primaryColor,
            cursorHeight: 20,
            decoration: InputDecoration(
              focusColor: theme.primaryColor,
              hoverColor: theme.primaryColor,
              hintStyle: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
              labelStyle: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
              fillColor: Colors.black54,
              iconColor: theme.primaryColor,
              labelText: '${widget.label} ${widget.isRequired ? '*' : ''}',
              hintText: widget.hint,
              suffixIcon: Visibility(
                visible: widget.isPassword,
                child: IconButton(
                  onPressed: () => _obscurePassword(!state),
                  icon: Icon(
                    state ? Icons.visibility : Icons.visibility_off,
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ),
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            textCapitalization: widget.textCapitalization,
            obscureText: state,
          );
        });
  }
}
