class Vehicle {
  final String id;
  final String name;
  final String category; // 'Traveller' or 'Tourist Bus'
  final int seatCount;
  final String tag;
  final String heroImageUrl;
  final List<String> galleryImages;
  final String shortDescription;
  final String fullDescription;
  final List<String> keyFeatures;
  final String acType;
  final String luggageCapacity;
  final String recommendedGroupSize;
  final String bestFor;
  final String seatingArrangement;
  final String startingRatePerKm;
  final bool isPopular;

  const Vehicle({
    required this.id,
    required this.name,
    required this.category,
    required this.seatCount,
    required this.tag,
    required this.heroImageUrl,
    required this.galleryImages,
    required this.shortDescription,
    required this.fullDescription,
    required this.keyFeatures,
    required this.acType,
    required this.luggageCapacity,
    required this.recommendedGroupSize,
    required this.bestFor,
    required this.seatingArrangement,
    required this.startingRatePerKm,
    this.isPopular = false,
  });
}
