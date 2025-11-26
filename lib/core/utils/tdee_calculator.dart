import 'dart:math';

enum ActivityLevel {
  sedentary,
  light,
  moderate,
  heavy,
  athlete,
}

enum Gender {
  male,
  female,
  other,
}

enum WeightGoal {
  lose,
  maintain,
  gain,
}

class TDEECalculator {
  /// Calculate Basal Metabolic Rate using Mifflin-St Jeor formula
  /// More accurate than Harris-Benedict for modern populations
  static double calculateBMR({
    required double weight, // kg
    required double height, // cm
    required int age,
    required Gender gender,
  }) {
    double bmr;
    
    if (gender == Gender.male) {
      // BMR (men) = (10 × weight) + (6.25 × height) - (5 × age) + 5
      bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      // BMR (women/other) = (10 × weight) + (6.25 × height) - (5 × age) - 161
      bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
    
    return bmr;
  }

  /// Get activity level multiplier
  static double getActivityMultiplier(ActivityLevel level) {
    switch (level) {
      case ActivityLevel.sedentary:
        return 1.2; // Little or no exercise
      case ActivityLevel.light:
        return 1.375; // Light exercise 1-3 days/week
      case ActivityLevel.moderate:
        return 1.55; // Moderate exercise 3-5 days/week
      case ActivityLevel.heavy:
        return 1.725; // Hard exercise 6-7 days/week
      case ActivityLevel.athlete:
        return 1.9; // Very hard exercise, physical job
    }
  }

  /// Calculate Total Daily Energy Expenditure
  static double calculateTDEE({
    required double bmr,
    required ActivityLevel activityLevel,
  }) {
    return bmr * getActivityMultiplier(activityLevel);
  }

  /// Calculate daily calorie target based on weight goal
  static double calculateDailyCalorieTarget({
    required double tdee,
    required WeightGoal goal,
  }) {
    switch (goal) {
      case WeightGoal.lose:
        return tdee - 500; // 0.5kg per week deficit
      case WeightGoal.maintain:
        return tdee;
      case WeightGoal.gain:
        return tdee + 300; // Lean muscle gain surplus
    }
  }

  /// Calculate macro targets (protein, carbs, fat)
  /// Returns map with grams for each macro
  static Map<String, int> calculateMacroTargets({
    required double dailyCalories,
    required double weight, // kg
    required WeightGoal goal,
  }) {
    // Protein: 2g per kg bodyweight (maintenance/gain), 2.2g for cutting
    double proteinGrams = goal == WeightGoal.lose ? weight * 2.2 : weight * 2.0;
    
    // Fat: 25% of total calories
    double fatCalories = dailyCalories * 0.25;
    double fatGrams = fatCalories / 9; // 9 calories per gram of fat
    
    // Carbs: remaining calories
    double proteinCalories = proteinGrams * 4; // 4 calories per gram
    double carbCalories = dailyCalories - proteinCalories - fatCalories;
    double carbGrams = carbCalories / 4; // 4 calories per gram
    
    return {
      'protein': proteinGrams.round(),
      'carbs': max(0, carbGrams.round()), // Ensure non-negative
      'fat': fatGrams.round(),
    };
  }

  /// Complete calculation returning all metrics
  static Map<String, dynamic> calculateAll({
    required double weight,
    required double height,
    required int age,
    required Gender gender,
    required ActivityLevel activityLevel,
    required WeightGoal goal,
  }) {
    final bmr = calculateBMR(
      weight: weight,
      height: height,
      age: age,
      gender: gender,
    );
    
    final tdee = calculateTDEE(
      bmr: bmr,
      activityLevel: activityLevel,
    );
    
    final dailyCalories = calculateDailyCalorieTarget(
      tdee: tdee,
      goal: goal,
    );
    
    final macros = calculateMacroTargets(
      dailyCalories: dailyCalories,
      weight: weight,
      goal: goal,
    );
    
    return {
      'bmr': bmr.round(),
      'tdee': tdee.round(),
      'dailyCalorieTarget': dailyCalories.round(),
      'macroTargets': macros,
    };
  }
}
