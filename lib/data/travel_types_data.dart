import 'package:flutter/material.dart';
import '../models/travel_type.dart';

class TravelTypesData {
  static const List<TravelType> travelTypes = [
    TravelType(
      id: 'family-tours',
      title: 'Family Tours',
      description: 'Comfortable, safe, and paced itineraries with generous legroom for kids and elderly parents.',
      icon: Icons.family_restroom_rounded,
      imageUrl: 'https://images.unsplash.com/photo-1599661046289-e31897846e41?q=80&w=600&auto=format&fit=crop',
    ),
    TravelType(
      id: 'friends-trips',
      title: 'Friends Trips',
      description: 'Exciting road trips, music-on-the-move, beach getaways, and unforgettable night campfires.',
      icon: Icons.groups_rounded,
      imageUrl: 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?q=80&w=600&auto=format&fit=crop',
    ),
    TravelType(
      id: 'corporate-tours',
      title: 'Corporate Tours',
      description: 'Punctual, executive transfers for annual team offsites, conferences, and executive leadership retreats.',
      icon: Icons.business_center_rounded,
      imageUrl: 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?q=80&w=600&auto=format&fit=crop',
    ),
    TravelType(
      id: 'college-tours',
      title: 'College Tours',
      description: 'Budget-optimized, high-energy industrial visits and graduation expeditions across Indian landmarks.',
      icon: Icons.school_rounded,
      imageUrl: 'https://images.unsplash.com/photo-1464219789935-c2d9d9aba644?q=80&w=600&auto=format&fit=crop',
    ),
    TravelType(
      id: 'pilgrimage-tours',
      title: 'Pilgrimage Tours',
      description: 'Spiritual circuits with seamless temple drop-offs, early morning coordination, and hygienic food stops.',
      icon: Icons.temple_hindu_rounded,
      imageUrl: 'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?q=80&w=600&auto=format&fit=crop',
    ),
    TravelType(
      id: 'honeymoon-trips',
      title: 'Honeymoon Trips',
      description: 'Intimate hill resorts, mist-laden pine walks, candle-lit dinners, and private scenic transfers.',
      icon: Icons.favorite_rounded,
      imageUrl: 'https://images.unsplash.com/photo-1598091383021-15ddea10925d?q=80&w=600&auto=format&fit=crop',
    ),
    TravelType(
      id: 'adventure-tours',
      title: 'Adventure Tours',
      description: 'High-altitude mountain crossings, river rafting, desert camping, and forest wildlife expeditions.',
      icon: Icons.terrain_rounded,
      imageUrl: 'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23?q=80&w=600&auto=format&fit=crop',
    ),
    TravelType(
      id: 'group-tours',
      title: 'Group Tours',
      description: 'Coordinated large tourist coaches accommodating 20 to 26 members with centralized luggage care.',
      icon: Icons.directions_bus_filled_rounded,
      imageUrl: 'https://images.unsplash.com/photo-1570125909232-eb263c188f7e?q=80&w=600&auto=format&fit=crop',
    ),
  ];
}
