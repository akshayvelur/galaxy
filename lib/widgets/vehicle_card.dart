import 'package:flutter/material.dart';
import '../models/vehicle.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'badge_pill.dart';
import 'custom_button.dart';

class VehicleCard extends StatefulWidget {
  final Vehicle vehicle;
  final VoidCallback onEnquire;
  final VoidCallback? onViewDetails;

  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.onEnquire,
    this.onViewDetails,
  });

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, -8))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: _isHovered
                ? AppColors.secondary.withOpacity(0.5)
                : AppColors.border,
            width: _isHovered ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppColors.primary.withOpacity(0.14)
                  : AppColors.primary.withOpacity(0.04),
              blurRadius: _isHovered ? 28 : 12,
              offset: Offset(0, _isHovered ? 14 : 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Large Vehicle Photo with Zoom Animation
              Stack(
                children: [
                  SizedBox(
                    height: 230,
                    width: double.infinity,
                    child: AnimatedScale(
                      scale: _isHovered ? 1.07 : 1.0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                      child: Image.network(
                        widget.vehicle.heroImageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.primaryLight,
                          child: const Center(
                            child: Icon(Icons.directions_bus, size: 54, color: Colors.white54),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Color(0x99070F1E),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Top Tag
                  Positioned(
                    top: 14,
                    left: 14,
                    child: BadgePill(
                      text: widget.vehicle.tag,
                      backgroundColor: AppColors.primary,
                      textColor: Colors.white,
                      icon: Icons.verified_rounded,
                    ),
                  ),
                  // Capacity pill
                  Positioned(
                    bottom: 14,
                    left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.airline_seat_recline_extra_rounded, size: 15, color: Colors.white),
                          const SizedBox(width: 6),
                          Text(
                            '${widget.vehicle.seatCount} SEATS',
                            style: AppTypography.badgeText.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Vehicle Information Content
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.vehicle.name.toUpperCase(),
                      style: AppTypography.headlineSmall.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.vehicle.category,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Key Bullets (The exact requirements from user prompt)
                    _buildFeatureRow(Icons.airline_seat_recline_normal, '${widget.vehicle.seatCount} Seats'),
                    const SizedBox(height: 8),
                    _buildFeatureRow(Icons.ac_unit_rounded, widget.vehicle.acType),
                    const SizedBox(height: 8),
                    _buildFeatureRow(Icons.luggage_outlined, widget.vehicle.luggageCapacity),
                    const SizedBox(height: 8),
                    _buildFeatureRow(Icons.groups_outlined, widget.vehicle.bestFor),

                    const SizedBox(height: 20),
                    const Divider(height: 1),
                    const SizedBox(height: 16),

                    // Price indicator & Enquire Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Base tariff',
                              style: AppTypography.bodySmall.copyWith(
                                fontSize: 11,
                                color: AppColors.textMuted,
                              ),
                            ),
                            Text(
                              widget.vehicle.startingRatePerKm,
                              style: AppTypography.titleMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        CustomButton(
                          text: 'Enquire Now',
                          icon: Icons.send_rounded,
                          variant: ButtonVariant.primary,
                          onPressed: widget.onEnquire,
                          fontSize: 13,
                          height: 42,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.secondary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bodyMedium.copyWith(
              fontSize: 13,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
