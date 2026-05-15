/// Curated popular cities grouped by continent for the bucket-list explorer.
class PopularDestinationCity {
  const PopularDestinationCity({
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  final String city;
  final String country;
  final double latitude;
  final double longitude;
}

class PopularDestinationRegion {
  const PopularDestinationRegion({
    required this.id,
    required this.name,
    required this.cities,
  });

  final String id;
  final String name;
  final List<PopularDestinationCity> cities;
}

/// Top 5 starter cities per region (expand to 50 per region later).
const List<PopularDestinationRegion> kPopularDestinationRegions =
    <PopularDestinationRegion>[
  PopularDestinationRegion(
    id: 'north_america',
    name: 'North America',
    cities: <PopularDestinationCity>[
      PopularDestinationCity(
        city: 'New York',
        country: 'United States',
        latitude: 40.7128,
        longitude: -74.0060,
      ),
      PopularDestinationCity(
        city: 'Los Angeles',
        country: 'United States',
        latitude: 34.0522,
        longitude: -118.2437,
      ),
      PopularDestinationCity(
        city: 'Mexico City',
        country: 'Mexico',
        latitude: 19.4326,
        longitude: -99.1332,
      ),
      PopularDestinationCity(
        city: 'Toronto',
        country: 'Canada',
        latitude: 43.6532,
        longitude: -79.3832,
      ),
      PopularDestinationCity(
        city: 'Cancún',
        country: 'Mexico',
        latitude: 21.1619,
        longitude: -86.8515,
      ),
    ],
  ),
  PopularDestinationRegion(
    id: 'south_america',
    name: 'South America',
    cities: <PopularDestinationCity>[
      PopularDestinationCity(
        city: 'Rio de Janeiro',
        country: 'Brazil',
        latitude: -22.9068,
        longitude: -43.1729,
      ),
      PopularDestinationCity(
        city: 'Buenos Aires',
        country: 'Argentina',
        latitude: -34.6037,
        longitude: -58.3816,
      ),
      PopularDestinationCity(
        city: 'Lima',
        country: 'Peru',
        latitude: -12.0464,
        longitude: -77.0428,
      ),
      PopularDestinationCity(
        city: 'Bogotá',
        country: 'Colombia',
        latitude: 4.7110,
        longitude: -74.0721,
      ),
      PopularDestinationCity(
        city: 'Santiago',
        country: 'Chile',
        latitude: -33.4489,
        longitude: -70.6693,
      ),
    ],
  ),
  PopularDestinationRegion(
    id: 'europe',
    name: 'Europe',
    cities: <PopularDestinationCity>[
      PopularDestinationCity(
        city: 'Paris',
        country: 'France',
        latitude: 48.8566,
        longitude: 2.3522,
      ),
      PopularDestinationCity(
        city: 'Rome',
        country: 'Italy',
        latitude: 41.9028,
        longitude: 12.4964,
      ),
      PopularDestinationCity(
        city: 'London',
        country: 'United Kingdom',
        latitude: 51.5074,
        longitude: -0.1278,
      ),
      PopularDestinationCity(
        city: 'Barcelona',
        country: 'Spain',
        latitude: 41.3851,
        longitude: 2.1734,
      ),
      PopularDestinationCity(
        city: 'Amsterdam',
        country: 'Netherlands',
        latitude: 52.3676,
        longitude: 4.9041,
      ),
    ],
  ),
  PopularDestinationRegion(
    id: 'asia',
    name: 'Asia',
    cities: <PopularDestinationCity>[
      PopularDestinationCity(
        city: 'Tokyo',
        country: 'Japan',
        latitude: 35.6762,
        longitude: 139.6503,
      ),
      PopularDestinationCity(
        city: 'Bangkok',
        country: 'Thailand',
        latitude: 13.7563,
        longitude: 100.5018,
      ),
      PopularDestinationCity(
        city: 'Singapore',
        country: 'Singapore',
        latitude: 1.3521,
        longitude: 103.8198,
      ),
      PopularDestinationCity(
        city: 'Dubai',
        country: 'United Arab Emirates',
        latitude: 25.2048,
        longitude: 55.2708,
      ),
      PopularDestinationCity(
        city: 'Seoul',
        country: 'South Korea',
        latitude: 37.5665,
        longitude: 126.9780,
      ),
    ],
  ),
  PopularDestinationRegion(
    id: 'africa',
    name: 'Africa',
    cities: <PopularDestinationCity>[
      PopularDestinationCity(
        city: 'Cape Town',
        country: 'South Africa',
        latitude: -33.9249,
        longitude: 18.4241,
      ),
      PopularDestinationCity(
        city: 'Marrakech',
        country: 'Morocco',
        latitude: 31.6295,
        longitude: -7.9811,
      ),
      PopularDestinationCity(
        city: 'Cairo',
        country: 'Egypt',
        latitude: 30.0444,
        longitude: 31.2357,
      ),
      PopularDestinationCity(
        city: 'Nairobi',
        country: 'Kenya',
        latitude: -1.2921,
        longitude: 36.8219,
      ),
      PopularDestinationCity(
        city: 'Lagos',
        country: 'Nigeria',
        latitude: 6.5244,
        longitude: 3.3792,
      ),
    ],
  ),
  PopularDestinationRegion(
    id: 'oceania',
    name: 'Oceania',
    cities: <PopularDestinationCity>[
      PopularDestinationCity(
        city: 'Sydney',
        country: 'Australia',
        latitude: -33.8688,
        longitude: 151.2093,
      ),
      PopularDestinationCity(
        city: 'Melbourne',
        country: 'Australia',
        latitude: -37.8136,
        longitude: 144.9631,
      ),
      PopularDestinationCity(
        city: 'Auckland',
        country: 'New Zealand',
        latitude: -36.8485,
        longitude: 174.7633,
      ),
      PopularDestinationCity(
        city: 'Queenstown',
        country: 'New Zealand',
        latitude: -45.0312,
        longitude: 168.6626,
      ),
      PopularDestinationCity(
        city: 'Bali',
        country: 'Indonesia',
        latitude: -8.3405,
        longitude: 115.0920,
      ),
    ],
  ),
];
