class Destination {
  final String id;
  final String name;
  final String state;
  final String region; // 'North India', 'South India', 'West India', 'East India', 'Northeast India'
  final String imageUrl;
  final String shortDescription;
  final String bestTimeToVisit;
  final List<String> famousAttractions;
  final String popularDuration;
  final bool isFeatured;

  const Destination({
    required this.id,
    required this.name,
    required this.state,
    required this.region,
    required this.imageUrl,
    required this.shortDescription,
    required this.bestTimeToVisit,
    required this.famousAttractions,
    required this.popularDuration,
    this.isFeatured = false,
  });
}
