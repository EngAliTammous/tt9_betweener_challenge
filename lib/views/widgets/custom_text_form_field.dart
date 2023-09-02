import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
    double? padding = 0 ;
  final String? hint;
  final TextEditingController? controller;
  final bool password;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final FocusNode? focusNode ;
  final Function(String)? onChanged ;
  final IconData? icon ;
   CustomTextFormField(
      {super.key,
      required this.label,
        this.icon ,
         this.focusNode,
         this.onChanged,
      this.controller,
      this.hint,
      this.password = false,
      this.keyboardType,
      this.validator,
        this.padding =0 ,
      this.autofillHints});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: padding!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Styles.textStyle14,
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            focusNode: focusNode,
            keyboardType: keyboardType,
            controller: controller,
            validator: validator,
            autofillHints: autofillHints,
            autofocus: true,
            obscureText: password,
            enableSuggestions: password == true ? false : true,
            autocorrect: password == true ? false : true,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              hintText: hint,
              border: Styles.primaryRoundedOutlineInputBorder,
              focusedBorder: Styles.primaryRoundedOutlineInputBorder,
              errorBorder: Styles.primaryRoundedOutlineInputBorder,
              enabledBorder: Styles.primaryRoundedOutlineInputBorder,
              disabledBorder: Styles.primaryRoundedOutlineInputBorder,
            ),
            onChanged: onChanged,

          ),
        ],
      ),
    );
  }
}
