import 'package:flutter/material.dart';
import '../data/faq_data.dart';
import '../models/faq_item.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import '../widgets/section_header.dart';

class FaqSection extends StatefulWidget {
  const FaqSection({super.key});

  @override
  State<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  int? _expandedIndex = 0; // Default first open

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);
    final faqs = FaqData.faqs;

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 75,
      ),
      child: Column(
        children: [
          const SectionHeader(
            kicker: 'Got Questions?',
            title: 'Frequently Asked Questions',
            subtitle:
                'Everything you need to know about vehicle rentals, custom tour planning, booking, and chauffeur safety.',
          ),
          const SizedBox(height: 48),

          // FAQ Accordion Cards
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 850),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: faqs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final faq = faqs[index];
                final isExpanded = _expandedIndex == index;

                return _buildFaqCard(faq, index, isExpanded);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqCard(FAQItem faq, int index, bool isExpanded) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpanded ? AppColors.secondary.withOpacity(0.5) : AppColors.border,
          width: isExpanded ? 1.5 : 1,
        ),
        boxShadow: isExpanded
            ? [
                BoxShadow(
                  color: AppColors.secondary.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: Key('faq_$index'),
          initiallyExpanded: isExpanded,
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          childrenPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isExpanded
                  ? AppColors.secondary.withOpacity(0.12)
                  : AppColors.background,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.help_outline_rounded,
              size: 20,
              color: isExpanded ? AppColors.secondary : AppColors.textMuted,
            ),
          ),
          title: Text(
            faq.question,
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: isExpanded ? AppColors.secondary : AppColors.textPrimary,
            ),
          ),
          trailing: Icon(
            isExpanded ? Icons.remove_circle_outline : Icons.add_circle_outline,
            color: isExpanded ? AppColors.secondary : AppColors.textMuted,
          ),
          onExpansionChanged: (expanded) {
            setState(() {
              _expandedIndex = expanded ? index : null;
            });
          },
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                faq.answer,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
