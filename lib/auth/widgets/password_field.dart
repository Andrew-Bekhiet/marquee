import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class PasswordField extends StatefulWidget {
  final String labelText;
  final String? errorText;
  final TextInputAction textInputAction;
  final List<String> autofillHints;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  const PasswordField({
    super.key,
    this.labelText = 'Password',
    this.errorText,
    this.textInputAction = TextInputAction.done,
    this.autofillHints = const [AutofillHints.password],
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.errorText,
        suffixIcon: IconButton(
          icon: _isPasswordVisible
              ? const Icon(Symbols.visibility_off)
              : const Icon(Symbols.visibility),
          onPressed: () =>
              setState(() => _isPasswordVisible = !_isPasswordVisible),
        ),
      ),
      autofillHints: widget.autofillHints,
      obscureText: !_isPasswordVisible,
      textInputAction: widget.textInputAction,
      keyboardType: _isPasswordVisible ? TextInputType.visiblePassword : null,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
