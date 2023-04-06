import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_better_life/widgets/container/container_shdow_inner.dart';


class InputTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextEditingController? confirmController;
  final Color? color;
  final Color? disabledColor;
  final AutovalidateMode? autoValidate;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final bool enabled;
  final int? maxLength;
  final double? borderRadius;
  final int minLines;
  final int maxLines;
  final String textInputFormatter;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final RegexConfig regexConfig;
  final bool isPassword;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final bool focus;
  final Function(String)? onChange;
  final EdgeInsetsGeometry? padding;
  final String? labelText;
  final bool? readOnly;
  final bool? autoFocus;
  final bool? isOptional;
  final bool? showCursor;
  final BorderType? borderType;
  final FocusNode? focusNode;
  final Function()? onTap;
  final bool? isRequired;
  final Color? colorLabel;
  final String? Function(String?)? validator;
  final TextAlign? textAlign;
  InputTextField({
    Key? key,
    this.controller,
    this.confirmController,
    this.color,
    this.disabledColor,
    this.autoValidate = AutovalidateMode.disabled,
    this.suffixIcon,
    this.prefixIcon,
    this.textStyle,
    this.enabled = true,
    this.maxLength,
    this.borderRadius,
    this.maxLines = 1,
    this.minLines = 1,
    this.textInputFormatter = r'.',
    this.inputFormatters,
    this.hintText,
    required this.regexConfig,
    this.isPassword = false,
    this.textInputAction = TextInputAction.done,
    this.keyboardType,
    this.focus = true,
    this.onChange,
    this.padding,
    this.labelText,
    this.readOnly,
    this.autoFocus,
    this.isOptional,
    this.showCursor,
    this.borderType,
    this.focusNode,
    this.onTap,
    this.isRequired,
    this.colorLabel,
    this.validator,
    this.textAlign,
  }) : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool error = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            widget.labelText ?? '',
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF000000).withOpacity(.7)
            ),
          ),
        ),
        const SizedBox(height: 5),
        ContainerShadowInner(
          error: error,
          size: const Size(double.infinity, 54),
          radiusParent: 18,
          radiusChild: 15,
          widthBorder: 1.5,
          child: TextFormField(
            autofocus: widget.autoFocus ?? false,
            onChanged: widget.onChange,
            controller: widget.controller,
            enabled: widget.enabled,
            focusNode: widget.focusNode,
            showCursor: widget.showCursor,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            obscureText: this.widget.isPassword,
            autovalidateMode: this.widget.autoValidate,
            readOnly: widget.readOnly ?? false,
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF000000).withOpacity(.7)
            ),
            textAlignVertical: TextAlignVertical.center,
            textAlign: widget.textAlign ?? TextAlign.left,
            onTap: widget.onTap,
            validator: widget.validator ??
              (value) {
                value = value?.trim() ?? '';
                if (!this.widget.regexConfig.getRegExp.hasMatch(value)) {
                  setState(() {
                    error = true;
                  });
                  return null;
                } else {
                  setState(() {
                    error = false;
                  });
                }
                if (widget.confirmController != null && widget.confirmController!.text.trim().compareTo(value) != 0) {
                  setState(() {
                    error = true;
                  });
                  return null;
                } else {
                  setState(() {
                    error = false;
                  });
                }
                return null;
              },
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            inputFormatters: this.widget.inputFormatters,
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              isCollapsed: true,
              enabledBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 11, horizontal: 15),
              focusedBorder: InputBorder.none,
              hintText: widget.hintText ?? 'Hint Text',
              hintStyle: TextStyle(
                fontSize: 16,
                color: const Color(0xFF000000).withOpacity(.7)
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              isDense: true,
              prefixIconConstraints: const BoxConstraints(
                maxHeight: 40,
                minHeight: 24,
              ),
              suffixIconConstraints: const BoxConstraints(
                maxHeight: 40,
                minHeight: 35,
              ),
            ),
          ),
        ),
        ..._buildErrorText()
      ],
    );
  }

  List<Widget> _buildErrorText() {
    if (error) {
      return <Widget>[
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            widget.regexConfig.errorText,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12
            ),
          ),
        )
      ];
    } else {
      return [];
    }
  }
}
