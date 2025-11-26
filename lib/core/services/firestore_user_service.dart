import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutriai/core/utils/tdee_calculator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_user_service.g.dart';

class UserProfile {
  final String name;
  final Gender gender;
  final int age;
  final double height; // cm
  final DateTime? dateOfBirth;
  final DateTime updatedAt;

  UserProfile({
    required this.name,
    required this.gender,
    required this.age,
    required this.height,
    this.dateOfBirth,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'gender': gender.name,
        'age': age,
        'height': height,
        'dateOfBirth': dateOfBirth != null ? Timestamp.fromDate(dateOfBirth!) : null,
        'updatedAt': Timestamp.fromDate(updatedAt),
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        name: json['name'] as String,
        gender: Gender.values.firstWhere((e) => e.name == json['gender']),
        age: json['age'] as int,
        height: (json['height'] as num).toDouble(),
        dateOfBirth: json['dateOfBirth'] != null ? (json['dateOfBirth'] as Timestamp).toDate() : null,
        updatedAt: (json['updatedAt'] as Timestamp).toDate(),
      );
}

class WeightTracking {
  final double initialWeight;
  final double currentWeight;
  final double targetWeight;
  final DateTime lastUpdatedAt;
  final List<WeightEntry> history;

  WeightTracking({
    required this.initialWeight,
    required this.currentWeight,
    required this.targetWeight,
    required this.lastUpdatedAt,
    this.history = const [],
  });

  Map<String, dynamic> toJson() => {
        'initialWeight': initialWeight,
        'currentWeight': currentWeight,
        'targetWeight': targetWeight,
        'lastUpdatedAt': Timestamp.fromDate(lastUpdatedAt),
        'history': history.map((e) => e.toJson()).toList(),
      };

  factory WeightTracking.fromJson(Map<String, dynamic> json) => WeightTracking(
        initialWeight: (json['initialWeight'] as num).toDouble(),
        currentWeight: (json['currentWeight'] as num).toDouble(),
        targetWeight: (json['targetWeight'] as num).toDouble(),
        lastUpdatedAt: (json['lastUpdatedAt'] as Timestamp).toDate(),
        history: (json['history'] as List?)?.map((e) => WeightEntry.fromJson(e)).toList() ?? [],
      );
}

class WeightEntry {
  final double weight;
  final DateTime date;
  final String source; // initial, chat, manual
  final String? note;

  WeightEntry({
    required this.weight,
    required this.date,
    required this.source,
    this.note,
  });

  Map<String, dynamic> toJson() => {
        'weight': weight,
        'date': Timestamp.fromDate(date),
        'source': source,
        if (note != null) 'note': note,
      };

  factory WeightEntry.fromJson(Map<String, dynamic> json) => WeightEntry(
        weight: (json['weight'] as num).toDouble(),
        date: (json['date'] as Timestamp).toDate(),
        source: json['source'] as String,
        note: json['note'] as String?,
      );
}

class UserGoals {
  final ActivityLevel activityLevel;
  final WeightGoal objective;
  final int tdee;
  final int bmr;
  final int dailyCalorieTarget;
  final Map<String, int> macroTargets;
  final DateTime calculatedAt;
  final DateTime updatedAt;

  UserGoals({
    required this.activityLevel,
    required this.objective,
    required this.tdee,
    required this.bmr,
    required this.dailyCalorieTarget,
    required this.macroTargets,
    required this.calculatedAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'activityLevel': activityLevel.name,
        'objective': objective.name,
        'tdee': tdee,
        'bmr': bmr,
        'dailyCalorieTarget': dailyCalorieTarget,
        'macroTargets': macroTargets,
        'calculatedAt': Timestamp.fromDate(calculatedAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
      };

  factory UserGoals.fromJson(Map<String, dynamic> json) => UserGoals(
        activityLevel: ActivityLevel.values.firstWhere((e) => e.name == json['activityLevel']),
        objective: WeightGoal.values.firstWhere((e) => e.name == json['objective']),
        tdee: json['tdee'] as int,
        bmr: json['bmr'] as int,
        dailyCalorieTarget: json['dailyCalorieTarget'] as int,
        macroTargets: Map<String, int>.from(json['macroTargets']),
        calculatedAt: (json['calculatedAt'] as Timestamp).toDate(),
        updatedAt: (json['updatedAt'] as Timestamp).toDate(),
      );
}

abstract class FirestoreUserService {
  Future<void> createUser(String userId, String email, {String? languageCode});
  Future<void> updateOnboardingStep(String userId, String step);
  Future<void> completeOnboarding(String userId);
  Future<void> saveUserProfile(String userId, UserProfile profile);
  Future<void> saveWeightTracking(String userId, WeightTracking weightTracking);
  Future<void> saveUserGoals(String userId, UserGoals goals);
  Future<void> updateWeight(String userId, double newWeight, String source, {String? note});
  Future<void> updateLanguage(String userId, String languageCode);
  Future<String?> getLanguage(String userId);
  Future<void> markLanguageSelected(String userId);
  Future<UserProfile?> getUserProfile(String userId);
  Future<WeightTracking?> getWeightTracking(String userId);
  Future<UserGoals?> getUserGoals(String userId);
  Future<Map<String, dynamic>?> getUserData(String userId);
}

class FirestoreUserServiceImpl implements FirestoreUserService {
  final FirebaseFirestore _firestore;

  FirestoreUserServiceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createUser(String userId, String email, {String? languageCode}) async {
    await _firestore.collection('users').doc(userId).set({
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
      'lastLoginAt': FieldValue.serverTimestamp(),
      'onboardingCompleted': false,
      'onboardingStep': 'welcome',
      'languageCode': languageCode ?? 'en',
      'languageSelected': false,
    });
  }

  @override
  Future<void> updateOnboardingStep(String userId, String step) async {
    await _firestore.collection('users').doc(userId).set({
      'onboardingStep': step,
    }, SetOptions(merge: true));
  }

  @override
  Future<void> completeOnboarding(String userId) async {
    await _firestore.collection('users').doc(userId).set({
      'onboardingCompleted': true,
      'onboardingStep': 'completed',
    }, SetOptions(merge: true));
  }

  @override
  Future<void> updateLanguage(String userId, String languageCode) async {
    await _firestore.collection('users').doc(userId).set({
      'languageCode': languageCode,
    }, SetOptions(merge: true));
  }

  @override
  Future<String?> getLanguage(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) return null;
    return doc.data()?['languageCode'] as String?;
  }

  @override
  Future<void> markLanguageSelected(String userId) async {
    await _firestore.collection('users').doc(userId).set({
      'languageSelected': true,
    }, SetOptions(merge: true));
  }

  @override
  Future<void> saveUserProfile(String userId, UserProfile profile) async {
    await _firestore.collection('users').doc(userId).collection('profile').doc('data').set(profile.toJson());
  }

  @override
  Future<void> saveWeightTracking(String userId, WeightTracking weightTracking) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('weight_tracking')
        .doc('current')
        .set(weightTracking.toJson());
  }

  @override
  Future<void> saveUserGoals(String userId, UserGoals goals) async {
    await _firestore.collection('users').doc(userId).collection('goals').doc('current').set(goals.toJson());
  }

  @override
  Future<void> updateWeight(String userId, double newWeight, String source, {String? note}) async {
    final now = DateTime.now();
    final newEntry = WeightEntry(
      weight: newWeight,
      date: now,
      source: source,
      note: note,
    );

    await _firestore.collection('users').doc(userId).collection('weight_tracking').doc('current').update({
      'currentWeight': newWeight,
      'lastUpdatedAt': Timestamp.fromDate(now),
      'history': FieldValue.arrayUnion([newEntry.toJson()]),
    });
  }

  @override
  Future<UserProfile?> getUserProfile(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).collection('profile').doc('data').get();
    if (!doc.exists) return null;
    return UserProfile.fromJson(doc.data()!);
  }

  @override
  Future<WeightTracking?> getWeightTracking(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).collection('weight_tracking').doc('current').get();
    if (!doc.exists) return null;
    return WeightTracking.fromJson(doc.data()!);
  }

  @override
  Future<UserGoals?> getUserGoals(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).collection('goals').doc('current').get();
    if (!doc.exists) return null;
    return UserGoals.fromJson(doc.data()!);
  }

  @override
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return doc.data();
  }
}

@riverpod
FirestoreUserService firestoreUserService(Ref ref) {
  return FirestoreUserServiceImpl();
}
