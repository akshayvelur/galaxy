import 'package:flutter/material.dart';
import '../data/gallery_data.dart';
import '../models/gallery_item.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/section_header.dart';

class GalleryPreviewSection extends StatefulWidget {
  final VoidCallback onViewFullGallery;

  const GalleryPreviewSection({
    super.key,
    required this.onViewFullGallery,
  });

  @override
  State<GalleryPreviewSection> createState() => _GalleryPreviewSectionState();
}

class _GalleryPreviewSectionState extends State<GalleryPreviewSection> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Vehicles',
    'Road Trips',
    'Destinations',
    'Happy Travellers',
    'Tour Experiences',
  ];

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);
    final items = GalleryData.getByCategory(_selectedCategory);

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
            kicker: 'Visual Journey',
            title: 'Moments from the Highway',
            subtitle:
                'Explore snapshots of our travellers in the mountains, sunlit expressway cruises, and happy groups across India.',
          ),
          const SizedBox(height: 36),

          // Categories Filter Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _categories.map((cat) {
                final bool isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: InkWell(
                    onTap: () => setState(() => _selectedCategory = cat),
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                        ),
                      ),
                      child: Text(
                        cat,
                        style: AppTypography.bodySmall.copyWith(
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 40),

          // Responsive Gallery Grid
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 3;
              if (constraints.maxWidth < 650) {
                crossAxisCount = 1;
              } else if (constraints.maxWidth < 1050) {
                crossAxisCount = 2;
              }

              final double cardWidth = (constraints.maxWidth - ((crossAxisCount - 1) * 20)) / crossAxisCount;

              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: items.take(6).map((item) {
                  return SizedBox(
                    width: cardWidth,
                    height: 260,
                    child: _buildGalleryTile(item),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 40),

          CustomButton(
            text: 'View Complete Photo Gallery',
            icon: Icons.photo_library_outlined,
            variant: ButtonVariant.outline,
            onPressed: widget.onViewFullGallery,
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryTile(GalleryItem item) {
    return _HoverGalleryItem(item: item);
  }
}

class _HoverGalleryItem extends StatefulWidget {
  final GalleryItem item;
  const _HoverGalleryItem({required this.item});

  @override
  State<_HoverGalleryItem> createState() => _HoverGalleryItemState();
}

class _HoverGalleryItemState extends State<_HoverGalleryItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // Image with hover zoom
            Positioned.fill(
              child: AnimatedScale(
                scale: _isHovered ? 1.08 : 1.0,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOut,
                child: Image.network(
                  widget.item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.primaryLight,
                    child: const Center(
                      child: Icon(Icons.image_outlined, size: 40, color: Colors.white38),
                    ),
                  ),
                ),
              ),
            ),

            // Animated Dark Gradient Overlay on hover
            Positioned.fill(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(_isHovered ? 0.85 : 0.4),
                    ],
                  ),
                ),
              ),
            ),

            // Text info & Location
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      widget.item.category.toUpperCase(),
                      style: AppTypography.badgeText.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.titleMedium.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.place_outlined, size: 14, color: AppColors.accent),
                      const SizedBox(width: 4),
                      Text(
                        widget.item.location,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.accent,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
