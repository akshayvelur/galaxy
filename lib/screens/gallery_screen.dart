import 'package:flutter/material.dart';
import '../data/gallery_data.dart';
import '../models/gallery_item.dart';
import '../sections/footer_section.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import '../utils/seo_helper.dart';
import '../widgets/app_drawer.dart';
import '../widgets/floating_whatsapp_button.dart';
import '../widgets/navbar.dart';

class GalleryScreen extends StatefulWidget {
  final Function(String route, {Map<String, dynamic>? arguments}) onNavigate;

  const GalleryScreen({
    super.key,
    required this.onNavigate,
  });

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
  void initState() {
    super.initState();
    SeoHelper.setTitle('Photo Gallery - Vehicles, Road Trips & India Destinations');
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);
    final bool isMobile = Responsive.isMobile(context);
    final items = GalleryData.getByCategory(_selectedCategory);

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        activeRoute: '/gallery',
        onNavigate: (route) => widget.onNavigate(route),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Header Banner
                Container(
                  width: double.infinity,
                  color: AppColors.primaryDark,
                  padding: EdgeInsets.only(
                    left: horizontalPadding,
                    right: horizontalPadding,
                    top: 130,
                    bottom: 60,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.secondary.withOpacity(0.4)),
                        ),
                        child: Text(
                          'PHOTO ARCHIVE',
                          style: AppTypography.badgeText.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Travel Gallery & Fleets',
                        textAlign: TextAlign.center,
                        style: (isMobile
                                ? AppTypography.headlineLarge
                                : AppTypography.displayMedium)
                            .copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 700),
                        child: Text(
                          'A visual showcase of our vehicles on Indian highways, majestic landscapes, and real group moments across the country.',
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyLarge.copyWith(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),

                // Gallery Grid with Category Filters
                Container(
                  width: double.infinity,
                  color: AppColors.background,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 50,
                  ),
                  child: Column(
                    children: [
                      // Filter Tabs
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _categories.map((cat) {
                            final isSelected = _selectedCategory == cat;
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: InkWell(
                                onTap: () => setState(() => _selectedCategory = cat),
                                borderRadius: BorderRadius.circular(24),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.primary : Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: isSelected ? AppColors.primary : AppColors.border,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.02),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
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
                            children: items.map((item) {
                              return SizedBox(
                                width: cardWidth,
                                height: 280,
                                child: _buildGalleryTile(item),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Footer
                FooterSection(onNavigate: (route) => widget.onNavigate(route)),
              ],
            ),
          ),

          // Sticky Top Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(
              isScrolled: true,
              activeRoute: '/gallery',
              onNavigate: (route) => widget.onNavigate(route),
              onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ),

          const FloatingWhatsAppButton(),
        ],
      ),
    );
  }

  Widget _buildGalleryTile(GalleryItem item) {
    return _GalleryItemCard(item: item);
  }
}

class _GalleryItemCard extends StatefulWidget {
  final GalleryItem item;
  const _GalleryItemCard({required this.item});

  @override
  State<_GalleryItemCard> createState() => _GalleryItemCardState();
}

class _GalleryItemCardState extends State<_GalleryItemCard> {
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
            Positioned.fill(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(_isHovered ? 0.88 : 0.45),
                    ],
                  ),
                ),
              ),
            ),
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
                  const SizedBox(height: 8),
                  Text(
                    widget.item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.titleMedium.copyWith(
                      color: Colors.white,
                      fontSize: 15,
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
