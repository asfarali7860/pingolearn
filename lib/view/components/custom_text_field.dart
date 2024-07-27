// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pingolearn/utils/app_sizes.dart';
import 'package:pingolearn/utils/colors.dart';

class CommonTextField extends StatefulWidget {
  final String hintText;
  final int? maxlength;
  final EdgeInsets padding;
  final int? maxLines;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final bool? obsecureText;
  final bool? enabled;
  final bool? isCapital;
  final FocusNode? focusNode;
  final bool? isValidating;
  final Function()? onEditingComplete;
  final Function(String)? onChange;
  final bool isPassword;

  const CommonTextField({
    this.onEditingComplete,
    this.maxlength = 100,
    required this.hintText,
    this.enabled = true,
    this.isCapital = false,
    required this.controller,
    this.isValidating = false,
    Key? key,
    this.validator,
    this.padding = const EdgeInsets.only(
      left: AppSizes.p14,
      right: AppSizes.p14,
    ),
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.focusNode,
    this.suffixWidget,
    this.prefixWidget,
    this.obsecureText = false,
    this.onChange,
    this.isPassword = false,
  }) : super(key: key);

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obsecureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: widget.maxLines! > 1 ? const EdgeInsets.symmetric(vertical: 16, horizontal: 4) : const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                ),
              ],
            ),
            child: TextFormField(
              autocorrect: false,
              maxLines: widget.maxLines,
              focusNode: widget.focusNode,
              maxLength: widget.maxlength,
              validator: widget.validator,
              enabled: widget.enabled,
              keyboardType: widget.keyboardType,
              textCapitalization: TextCapitalization.sentences,
              obscureText: _obscureText,
              onTapOutside: (PointerDownEvent event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onFieldSubmitted: (value) {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              onEditingComplete: () {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              onChanged: widget.onChange,
              controller: widget.controller,
              style: const TextStyle(color: kBlack),
              decoration: InputDecoration(
                counterText: "",
                contentPadding: const EdgeInsets.only(left: 10),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                hintText: widget.hintText,
                hintStyle: GoogleFonts.poppins(
                  color: kBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : widget.suffixWidget,
                prefixIcon: widget.prefixWidget,
              ),
            ),
          ),
          gapH10,
          if (widget.isValidating ?? true) Text(widget.validator?.call("").toString() ?? "") else Container(),
        ],
      ),
    );
  }
}
