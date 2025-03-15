import 'package:flutter/material.dart';

class MyFormField extends StatefulWidget {
  final String label;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const MyFormField({
    super.key,
    required this.label,
    required this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.validator,
  });

  @override
  State<MyFormField> createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  bool hidden = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      obscureText: hidden,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        label: Text(
          widget.label,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon != null
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    hidden = !hidden;
                  });
                },
                child: widget.suffixIcon,
              )
            : SizedBox.shrink(),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
