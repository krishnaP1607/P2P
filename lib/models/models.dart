class Parcel {
  final String id;
  final String from;
  final String to;
  final String size; // Small, Medium, Large
  final double weight; // in kg
  final double traditionalPrice;
  final double p2pPrice;
  final double travelerEarnings;
  final double distance; // in km
  final Hub pickupHub;
  final Hub deliveryHub;

  Parcel({
    required this.id,
    required this.from,
    required this.to,
    required this.size,
    required this.weight,
    required this.traditionalPrice,
    required this.p2pPrice,
    required this.travelerEarnings,
    required this.distance,
    required this.pickupHub,
    required this.deliveryHub,
  });

  double get savings => traditionalPrice - p2pPrice;
  double get savingsPercentage => (savings / traditionalPrice) * 100;
}

class Traveler {
  final String id;
  final String name;
  final String avatarUrl;
  final double rating;
  final int totalDeliveries;
  final RouteInfo route;
  final double totalEarnings;

  Traveler({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.rating,
    required this.totalDeliveries,
    required this.route,
    this.totalEarnings = 0.0,
  });
}

class Hub {
  final String id;
  final String name;
  final String type; // Cafe, Shop, Community Center
  final String address;
  final double latitude;
  final double longitude;
  final double distanceFromUser; // in km

  Hub({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.distanceFromUser = 0.0,
  });

  String get icon {
    switch (type.toLowerCase()) {
      case 'cafe':
        return '☕';
      case 'shop':
        return '🏪';
      case 'community center':
        return '🏢';
      default:
        return '📍';
    }
  }
}

class RouteInfo {
  final String from;
  final String to;
  final List<String> waypoints;

  RouteInfo({
    required this.from,
    required this.to,
    this.waypoints = const [],
  });

  String get displayRoute => '$from → $to';
}

class DeliveryRequest {
  final String id;
  final Parcel parcel;
  final String senderId;
  final Traveler? assignedTraveler;
  final DeliveryStatus status;
  final DateTime createdAt;

  DeliveryRequest({
    required this.id,
    required this.parcel,
    required this.senderId,
    this.assignedTraveler,
    required this.status,
    required this.createdAt,
  });
}

enum DeliveryStatus {
  pending,
  matched,
  pickedUp,
  inTransit,
  delivered,
  cancelled,
}

class Statistics {
  final double totalSavings;
  final int totalDeliveries;
  final double co2Saved; // in kg
  final int activeTravelers;
  final int availableParcels;

  Statistics({
    required this.totalSavings,
    required this.totalDeliveries,
    required this.co2Saved,
    required this.activeTravelers,
    required this.availableParcels,
  });
}
