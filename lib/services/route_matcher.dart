import '../models/models.dart';

class RouteMatcher {
  // Match travelers to a parcel based on route overlap
  static List<Traveler> matchTravelersToParcel(
    Parcel parcel,
    List<Traveler> availableTravelers,
  ) {
    final matches = <Traveler>[];
    
    for (final traveler in availableTravelers) {
      if (_isRouteCompatible(parcel, traveler.route)) {
        matches.add(traveler);
      }
    }
    
    // Sort by rating (highest first)
    matches.sort((a, b) => b.rating.compareTo(a.rating));
    
    return matches;
  }
  
  // Match parcels to a traveler's route
  static List<Parcel> matchParcelsToTraveler(
    RouteInfo travelerRoute,
    List<Parcel> availableParcels,
  ) {
    final matches = <Parcel>[];
    
    for (final parcel in availableParcels) {
      if (_isRouteCompatibleForTraveler(travelerRoute, parcel)) {
        matches.add(parcel);
      }
    }
    
    // Sort by earnings (highest first)
    matches.sort((a, b) => b.travelerEarnings.compareTo(a.travelerEarnings));
    
    return matches;
  }
  
  // Check if traveler's route is compatible with parcel
  static bool _isRouteCompatible(Parcel parcel, RouteInfo travelerRoute) {
    // Simple matching based on location names
    // In a real app, this would use geolocation and route optimization
    final from = parcel.from.toLowerCase();
    final to = parcel.to.toLowerCase();
    final routeFrom = travelerRoute.from.toLowerCase();
    final routeTo = travelerRoute.to.toLowerCase();
    
    // Check if parcel route matches or is close to traveler route
    return (from.contains(routeFrom) || routeFrom.contains(from)) &&
           (to.contains(routeTo) || routeTo.contains(to));
  }
  
  // Check if parcel is compatible with traveler's route
  static bool _isRouteCompatibleForTraveler(RouteInfo travelerRoute, Parcel parcel) {
    return _isRouteCompatible(parcel, travelerRoute);
  }
  
  // Calculate route proximity score (0-100)
  static double calculateProximityScore(String location1, String location2) {
    // Simple similarity check
    // In a real app, this would use actual geographic distance
    final loc1 = location1.toLowerCase();
    final loc2 = location2.toLowerCase();
    
    if (loc1 == loc2) return 100.0;
    if (loc1.contains(loc2) || loc2.contains(loc1)) return 80.0;
    
    return 0.0;
  }
}
