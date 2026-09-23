import 'package:flutter/material.dart';
import '../data/testimonials_data.dart';
import '../models/testimonial.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import '../widgets/section_header.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);
    final reviews = TestimonialsData.testimonials;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 75,
      ),
      child: Column(
        children: [
          const SectionHeader(
            kicker: 'Verified Guest Experiences',
            title: 'Trusted by Groups Across India',
            subtitle:
                'Read real feedback from families, corporate teams, and friend circles who toured with our travellers and coaches.',
          ),
          const SizedBox(height: 50),

          // Responsive Testimonials Grid / List
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 3;
              if (constraints.maxWidth < 750) {
                crossAxisCount = 1;
              } else if (constraints.maxWidth < 1100) {
                crossAxisCount = 2;
              }

              final double cardWidth = (constraints.maxWidth - ((crossAxisCount - 1) * 24)) / crossAxisCount;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: reviews.take(3).map((review) {
                  return SizedBox(
                    width: cardWidth,
                    child: _buildReviewCard(review),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Testimonial review) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.03),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 5-Star Rating Row
          Row(
            children: [
              ...List.generate(
                5,
                (index) => const Icon(
                  Icons.star_rounded,
                  color: AppColors.accent,
                  size: 22,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.verified, size: 12, color: AppColors.success),
                    const SizedBox(width: 4),
                    Text(
                      'Verified Trip',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.success,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Review Quote
          Text(
            '"${review.review}"',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontStyle: FontStyle.italic,
              height: 1.6,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // Customer Name & Destination Visited
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: review.avatarUrl != null ? NetworkImage(review.avatarUrl!) : null,
                backgroundColor: AppColors.secondary.withOpacity(0.2),
                child: review.avatarUrl == null
                    ? Text(
                        review.authorName[0],
                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.authorName,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${review.destinationVisited} • ${review.city}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.secondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Vehicle: ${review.vehicleUsed}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodySmall.copyWith(
                        fontSize: 10,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
