import 'faq_item.dart';

class ItineraryDay {
  final int dayNumber;
  final String title;
  final String description;
  final List<String> activities;
  final String stayCity;
  final String meals;

  const ItineraryDay({
    required this.dayNumber,
    required this.title,
    required this.description,
    required this.activities,
    required this.stayCity,
    required this.meals,
  });
}

class TourPackage {
  final String id;
  final String title;
  final String destination;
  final String region; // 'South India', 'North India', 'West India', 'East India', 'Northeast India'
  final String duration; // e.g. "5 Days / 4 Nights"
  final int daysCount;
  final int nightsCount;
  final String startingPrice; // e.g. "₹12,499"
  final String heroImageUrl;
  final List<String> galleryImages;
  final String shortDescription;
  final String overview;
  final String? badge; // 'Bestseller', 'Popular', 'Trending', 'Heritage'
  final double rating;
  final int reviewsCount;
  final List<String> highlights;
  final List<String> placesCovered;
  final List<String> vehicleOptions;
  final String hotelInfo;
  final String mealsInfo;
  final List<ItineraryDay> itinerary;
  final List<String> inclusions;
  final List<String> exclusions;
  final List<String> importantNotes;
  final List<FAQItem> faqs;

  const TourPackage({
    required this.id,
    required this.title,
    required this.destination,
    required this.region,
    required this.duration,
    required this.daysCount,
    required this.nightsCount,
    required this.startingPrice,
    required this.heroImageUrl,
    required this.galleryImages,
    required this.shortDescription,
    required this.overview,
    this.badge,
    this.rating = 4.9,
    this.reviewsCount = 42,
    required this.highlights,
    required this.placesCovered,
    required this.vehicleOptions,
    required this.hotelInfo,
    required this.mealsInfo,
    required this.itinerary,
    required this.inclusions,
    required this.exclusions,
    required this.importantNotes,
    this.faqs = const [],
  });
}
