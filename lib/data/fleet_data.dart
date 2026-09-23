import '../models/vehicle.dart';

class FleetData {
  static const List<Vehicle> vehicles = [
    Vehicle(
      id: '16-seat-traveller',
      name: '16 Seat Traveller',
      category: 'Force Traveller Luxury',
      seatCount: 16,
      tag: 'Ideal for Small Groups',
      heroImageUrl: 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?q=80&w=1200&auto=format&fit=crop',
      galleryImages: [
        'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?q=80&w=1200&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1570125909232-eb263c188f7e?q=80&w=1200&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1494515843206-f3117d3f51b7?q=80&w=1200&auto=format&fit=crop',
      ],
      shortDescription: 'Compact yet spacious luxury traveller designed for effortless hill climbs, highway touring, and intimate group trips.',
      fullDescription: 'Our 16-Seat Force Traveller is engineered specifically for premium small group travels, hill station excursions, and corporate delegations. Features executive push-back recliner seats, powerful twin AC blowers for Indian summers, dedicated reading lights, USB charging sockets at every seat, and a generous rear boot space for large travel suitcases.',
      keyFeatures: [
        '16 Executive Recliner Seats (2x1 layout)',
        'Twin High-Cooling AC blowers',
        'Individual USB fast-charging ports',
        'Dedicated rear boot for up to 14 large bags',
        'High ground clearance for hill curves & ghats',
        'Certified chauffeur with 8+ years highway experience',
      ],
      acType: 'Powerful Twin Rooftop AC',
      luggageCapacity: '12-14 Large Strolley Bags + Cabin Space',
      recommendedGroupSize: '10 to 15 Passengers',
      bestFor: 'Small Groups, Family Holidays, Friends Road Trips',
      seatingArrangement: '2x1 Luxury Pushback',
      startingRatePerKm: '₹22 / km',
      isPopular: false,
    ),
    Vehicle(
      id: '18-seat-traveller',
      name: '18 Seat Traveller',
      category: 'Force Traveller Extended',
      seatCount: 18,
      tag: 'Most Popular for Families',
      heroImageUrl: 'https://images.unsplash.com/photo-1570125909232-eb263c188f7e?q=80&w=1200&auto=format&fit=crop',
      galleryImages: [
        'https://images.unsplash.com/photo-1570125909232-eb263c188f7e?q=80&w=1200&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?q=80&w=1200&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1464219789935-c2d9d9aba644?q=80&w=1200&auto=format&fit=crop',
      ],
      shortDescription: 'The gold standard in Indian road touring. Superior comfort interiors, extended legroom, and generous luggage space.',
      fullDescription: 'The 18-Seat Extended Traveller is the undisputed favorite for extended family vacations, golden triangle heritage circuits, and multi-state temple expeditions. Offering wide aisle clearance, plush acoustic insulation against road noise, ambient mood lighting, clean sanitized upholstery, and an extra-large overhead baggage bay.',
      keyFeatures: [
        '18 Push-back Ergonomic Recliner Seats',
        'Multi-vent Climate Controlled Central AC',
        'Surround Sound Audio System & LED TV Screen',
        'Expanded Luggage Compartment + Roof Carrier',
        'First Aid Emergency Kit & Speed Governor',
        'GPS live tracking with driver SOS integration',
      ],
      acType: 'Full Cabin Multi-vent Air Conditioning',
      luggageCapacity: '16-18 Large Suitcases + Overhead Racks',
      recommendedGroupSize: '14 to 17 Passengers',
      bestFor: 'Family & Group Tours, Multi-day Pilgrimages',
      seatingArrangement: '2x1 Extended Comfort Recliner',
      startingRatePerKm: '₹24 / km',
      isPopular: true,
    ),
    Vehicle(
      id: '26-seat-tourist-bus',
      name: '26 Seat Tourist Bus',
      category: 'Executive Coach Bus',
      seatCount: 26,
      tag: 'Large Group Specialist',
      heroImageUrl: 'https://images.unsplash.com/photo-1464219789935-c2d9d9aba644?q=80&w=1200&auto=format&fit=crop',
      galleryImages: [
        'https://images.unsplash.com/photo-1464219789935-c2d9d9aba644?q=80&w=1200&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?q=80&w=1200&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1570125909232-eb263c188f7e?q=80&w=1200&auto=format&fit=crop',
      ],
      shortDescription: 'Heavy-duty luxury mini coach designed for wedding parties, corporate offsites, college tours, and large group pilgrimages.',
      fullDescription: 'Experience grand group comfort in our 26-Seat Luxury Tourist Coach. Featuring air-suspension ride dynamics that iron out highway bumps, wide panoramic tinted windows for scenic sightseeing, generous aisle space, microphone PA system for tour guides, and massive underfloor luggage lockers.',
      keyFeatures: [
        '26 Ultra-comfort High Back Reclining Seats',
        'Air-suspension shock dampening system',
        'Heavy-duty chiller AC with individual louvers',
        'Massive underfloor luggage holds + roof storage',
        'PA microphone system for guide announcements',
        'Dual emergency exit doors & digital fire sensors',
      ],
      acType: 'High-Capacity Chiller AC with Louvers',
      luggageCapacity: '26-30 Heavy Bags in Underbelly Lockers',
      recommendedGroupSize: '20 to 26 Passengers',
      bestFor: 'Corporate Outings, College Tours, Large Groups',
      seatingArrangement: '2x2 High-back Reclining Coach',
      startingRatePerKm: '₹34 / km',
      isPopular: false,
    ),
  ];

  static Vehicle getById(String id) {
    return vehicles.firstWhere(
      (v) => v.id == id,
      orElse: () => vehicles.first,
    );
  }
}
