import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

enum ButtonVariant { primary, secondary, outline, text }

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final IconData? icon;
  final bool isFullWidth;
  final double? height;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.isFullWidth = false,
    this.height,
    this.fontSize,
    this.padding,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color getBgColor() {
      switch (widget.variant) {
        case ButtonVariant.primary:
          return _isHovered ? AppColors.secondaryHover : AppColors.secondary;
        case ButtonVariant.secondary:
          return _isHovered ? AppColors.primaryLight : AppColors.primary;
        case ButtonVariant.outline:
          return _isHovered ? AppColors.secondary.withOpacity(0.08) : Colors.transparent;
        case ButtonVariant.text:
          return _isHovered ? AppColors.secondary.withOpacity(0.08) : Colors.transparent;
      }
    }

    Color getTextColor() {
      switch (widget.variant) {
        case ButtonVariant.primary:
        case ButtonVariant.secondary:
          return Colors.white;
        case ButtonVariant.outline:
          return _isHovered ? AppColors.secondaryHover : AppColors.secondary;
        case ButtonVariant.text:
          return _isHovered ? AppColors.secondaryHover : AppColors.secondary;
      }
    }

    Border? getBorder() {
      if (widget.variant == ButtonVariant.outline) {
        return Border.all(
          color: _isHovered ? AppColors.secondaryHover : AppColors.secondary,
          width: 1.5,
        );
      }
      return null;
    }

    return MouseRegion(
      cursor: widget.onPressed != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        height: widget.height ?? 48,
        width: widget.isFullWidth ? double.infinity : null,
        transform: _isHovered && widget.onPressed != null
            ? (Matrix4.identity()..translate(0, -2))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: getBgColor(),
          border: getBorder(),
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isHovered &&
                  widget.onPressed != null &&
                  widget.variant != ButtonVariant.text
              ? [
                  BoxShadow(
                    color: widget.variant == ButtonVariant.primary
                        ? AppColors.secondary.withOpacity(0.35)
                        : AppColors.primary.withOpacity(0.25),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: widget.onPressed,
            child: Padding(
              padding: widget.padding ??
                  const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              child: Row(
                mainAxisSize:
                    widget.isFullWidth ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, size: 18, color: getTextColor()),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.text,
                    style: AppTypography.labelLarge.copyWith(
                      color: getTextColor(),
                      fontSize: widget.fontSize ?? 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
