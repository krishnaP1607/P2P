class CostCalculator {
  // Base rates
  static const double traditionalBaseRate = 40.0;
  static const double traditionalPerKmRate = 12.0;
  static const double p2pBaseRate = 15.0;
  static const double p2pPerKmRate = 3.0;
  
  // Calculate traditional delivery cost
  static double calculateTraditionalCost(double distanceKm) {
    return traditionalBaseRate + (distanceKm * traditionalPerKmRate);
  }
  
  // Calculate P2P delivery cost (shared route discount)
  static double calculateP2PCost(double distanceKm) {
    return p2pBaseRate + (distanceKm * p2pPerKmRate);
  }
  
  // Calculate traveler earnings (70% of P2P cost)
  static double calculateTravelerEarnings(double p2pCost) {
    return p2pCost * 0.7;
  }
  
  // Calculate savings
  static double calculateSavings(double traditionalCost, double p2pCost) {
    return traditionalCost - p2pCost;
  }
  
  // Calculate savings percentage
  static double calculateSavingsPercentage(double traditionalCost, double p2pCost) {
    if (traditionalCost == 0) return 0;
    return ((traditionalCost - p2pCost) / traditionalCost) * 100;
  }
  
  // Get full cost breakdown
  static Map<String, double> getCostBreakdown(double distanceKm) {
    final traditionalCost = calculateTraditionalCost(distanceKm);
    final p2pCost = calculateP2PCost(distanceKm);
    final travelerEarnings = calculateTravelerEarnings(p2pCost);
    final savings = calculateSavings(traditionalCost, p2pCost);
    final savingsPercentage = calculateSavingsPercentage(traditionalCost, p2pCost);
    
    return {
      'traditionalCost': traditionalCost,
      'p2pCost': p2pCost,
      'travelerEarnings': travelerEarnings,
      'savings': savings,
      'savingsPercentage': savingsPercentage,
    };
  }
}
