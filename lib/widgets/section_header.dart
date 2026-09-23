import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';

class SectionHeader extends StatelessWidget {
  final String? kicker;
  final String title;
  final String? subtitle;
  final bool isCentered;
  final bool isDark;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    this.kicker,
    required this.title,
    this.subtitle,
    this.isCentered = true,
    this.isDark = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment:
          isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        if (kicker != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.secondary.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              kicker!.toUpperCase(),
              style: AppTypography.badgeText.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        Text(
          title,
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
          style: (isMobile
                  ? AppTypography.headlineMedium
                  : AppTypography.displayMedium)
              .copyWith(
            color: isDark ? Colors.white : AppColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              subtitle!,
              textAlign: isCentered ? TextAlign.center : TextAlign.start,
              style: AppTypography.bodyLarge.copyWith(
                color: isDark ? AppColors.textLightMuted : AppColors.textSecondary,
                fontSize: isMobile ? 14 : 16,
              ),
            ),
          ),
        ],
        if (trailing != null) ...[
          const SizedBox(height: 16),
          trailing!,
        ],
      ],
    );
  }
}
