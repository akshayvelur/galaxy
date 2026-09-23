import 'package:flutter/material.dart';
import '../data/fleet_data.dart';
import '../models/vehicle.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/section_header.dart';

class VehicleComparisonSection extends StatelessWidget {
  final Function(Vehicle vehicle) onChooseVehicle;

  const VehicleComparisonSection({
    super.key,
    required this.onChooseVehicle,
  });

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);
    final vehicles = FleetData.vehicles;

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 70,
      ),
      child: Column(
        children: [
          const SectionHeader(
            kicker: 'Side-by-Side Comparison',
            title: 'Find the Perfect Vehicle for Your Group',
            subtitle:
                'Compare seating configurations, luggage boot capacities, climate control, and ideal group requirements at a glance.',
          ),
          const SizedBox(height: 48),

          // Responsive Comparison Container
          LayoutBuilder(
            builder: (context, constraints) {
              final bool isNarrow = constraints.maxWidth < 800;

              if (isNarrow) {
                // Mobile Tabular Card layout
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 700),
                    child: _buildComparisonTable(context, vehicles),
                  ),
                );
              }

              return _buildComparisonTable(context, vehicles);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonTable(BuildContext context, List<Vehicle> vehicles) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FlexColumnWidth(1.4),
            1: FlexColumnWidth(2.0),
            2: FlexColumnWidth(2.0),
            3: FlexColumnWidth(2.0),
          },
          border: const TableBorder(
            horizontalInside: BorderSide(color: AppColors.border, width: 1),
            verticalInside: BorderSide(color: AppColors.border, width: 1),
          ),
          children: [
            // Header Row: Vehicle Titles
            TableRow(
              decoration: const BoxDecoration(
                color: AppColors.primaryDark,
              ),
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'SPECIFICATION',
                    style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                ...vehicles.map((v) => Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            v.name.toUpperCase(),
                            style: AppTypography.titleMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            v.category,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.accent,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),

            // Row 1: Seats
            _buildTableRow(
              'Seats',
              vehicles.map((v) => '${v.seatCount} Reclining Seats').toList(),
              isHighlight: true,
            ),

            // Row 2: AC
            _buildTableRow(
              'Air Conditioning',
              vehicles.map((v) => v.acType).toList(),
            ),

            // Row 3: Luggage
            _buildTableRow(
              'Luggage Capacity',
              vehicles.map((v) => v.luggageCapacity).toList(),
            ),

            // Row 4: Recommended Group Size
            _buildTableRow(
              'Recommended Group Size',
              vehicles.map((v) => v.recommendedGroupSize).toList(),
              isHighlight: true,
            ),

            // Row 5: Best For
            _buildTableRow(
              'Best For',
              vehicles.map((v) => v.bestFor).toList(),
            ),

            // Row 6: Choose Vehicle CTA Buttons
            TableRow(
              decoration: const BoxDecoration(color: Color(0xFFFAFBFD)),
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Action',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textSecondary),
                  ),
                ),
                ...vehicles.map((v) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomButton(
                        text: 'Choose Vehicle',
                        variant: v.isPopular ? ButtonVariant.primary : ButtonVariant.outline,
                        height: 42,
                        fontSize: 12,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        onPressed: () => onChooseVehicle(v),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, List<String> values, {bool isHighlight = false}) {
    return TableRow(
      decoration: BoxDecoration(
        color: isHighlight ? AppColors.secondary.withOpacity(0.02) : Colors.white,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        ...values.map((val) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Text(
                val,
                style: AppTypography.bodySmall.copyWith(
                  color: isHighlight ? AppColors.primary : AppColors.textSecondary,
                  fontWeight: isHighlight ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            )),
      ],
    );
  }
}
