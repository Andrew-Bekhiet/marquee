import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const PasswordField({
  super.key,
  final String labelText = 'Password',
  final String? errorText,
  final TextInputAction textInputAction = TextInputAction.done,
  final List<String> autofillHints = const [AutofillHints.password],
  final ValueChanged<String>? onChanged,
  final ValueChanged<String>? onFieldSubmitted,
}) extends StatefulWidget {
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState() extends State<PasswordField> {
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
