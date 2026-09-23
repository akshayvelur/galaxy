import 'package:flutter/material.dart';
import '../data/fleet_data.dart';
import '../models/vehicle.dart';
import '../utils/responsive.dart';
import '../widgets/section_header.dart';
import '../widgets/vehicle_card.dart';

class FleetShowcaseSection extends StatelessWidget {
  final Function(Vehicle vehicle) onEnquireVehicle;
  final VoidCallback onViewFullFleet;

  const FleetShowcaseSection({
    super.key,
    required this.onEnquireVehicle,
    required this.onViewFullFleet,
  });

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.horizontalPadding(context);
    final vehicles = FleetData.vehicles;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 70,
      ),
      child: Column(
        children: [
          // Section Header
          const SectionHeader(
            kicker: 'Our Fleet',
            title: 'Travel Together. Travel Comfortably.',
            subtitle:
                'Modern, climate-controlled, commercial tourist vehicles maintained to strict safety standards with experienced highway chauffeurs.',
          ),
          const SizedBox(height: 50),

          // 3 Vehicle Cards in responsive layout
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 950) {
                // Stack vertically on tablet & mobile
                return Column(
                  children: vehicles.map((vehicle) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: VehicleCard(
                        vehicle: vehicle,
                        onEnquire: () => onEnquireVehicle(vehicle),
                      ),
                    );
                  }).toList(),
                );
              }

              // 3-column row on Desktop
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: vehicles.map((vehicle) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: VehicleCard(
                        vehicle: vehicle,
                        onEnquire: () => onEnquireVehicle(vehicle),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
