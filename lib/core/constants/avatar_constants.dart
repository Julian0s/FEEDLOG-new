/// Avatar constants using DiceBear Personas style
/// Supports random avatar generation and history
library;

import 'dart:math';

class AvatarConstants {
  AvatarConstants._();

  /// Base URL for DiceBear API (personas style - illustrated colorful avatars)
  static const String baseUrl = 'https://api.dicebear.com/9.x/personas/svg';

  /// Gera 12 avatares com seeds aleatórios
  static List<Map<String, String>> generateRandomAvatars() {
    final random = Random();
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    return List.generate(12, (index) {
      final seed = '${timestamp}_${random.nextInt(999999)}_$index';
      return {
        'id': 'random_$seed',
        'url': '$baseUrl?seed=$seed',
      };
    });
  }

  /// Gera URL de avatar a partir de um seed
  static String getAvatarUrl(String seed) {
    return '$baseUrl?seed=$seed';
  }

  /// Male avatars - diverse seeds for variety
  static const List<Map<String, String>> maleAvatars = [
    {'id': 'male_1', 'url': '$baseUrl?seed=Felix'},
    {'id': 'male_2', 'url': '$baseUrl?seed=Marcus'},
    {'id': 'male_3', 'url': '$baseUrl?seed=Oliver'},
    {'id': 'male_4', 'url': '$baseUrl?seed=Leo'},
    {'id': 'male_5', 'url': '$baseUrl?seed=Noah'},
    {'id': 'male_6', 'url': '$baseUrl?seed=Lucas'},
    {'id': 'male_7', 'url': '$baseUrl?seed=Ethan'},
    {'id': 'male_8', 'url': '$baseUrl?seed=Mason'},
    {'id': 'male_9', 'url': '$baseUrl?seed=Logan'},
    {'id': 'male_10', 'url': '$baseUrl?seed=James'},
    {'id': 'male_11', 'url': '$baseUrl?seed=Alexander'},
    {'id': 'male_12', 'url': '$baseUrl?seed=William'},
  ];

  /// Female avatars - diverse seeds for variety
  static const List<Map<String, String>> femaleAvatars = [
    {'id': 'female_1', 'url': '$baseUrl?seed=Sophie'},
    {'id': 'female_2', 'url': '$baseUrl?seed=Emma'},
    {'id': 'female_3', 'url': '$baseUrl?seed=Olivia'},
    {'id': 'female_4', 'url': '$baseUrl?seed=Ava'},
    {'id': 'female_5', 'url': '$baseUrl?seed=Isabella'},
    {'id': 'female_6', 'url': '$baseUrl?seed=Mia'},
    {'id': 'female_7', 'url': '$baseUrl?seed=Charlotte'},
    {'id': 'female_8', 'url': '$baseUrl?seed=Amelia'},
    {'id': 'female_9', 'url': '$baseUrl?seed=Harper'},
    {'id': 'female_10', 'url': '$baseUrl?seed=Evelyn'},
    {'id': 'female_11', 'url': '$baseUrl?seed=Luna'},
    {'id': 'female_12', 'url': '$baseUrl?seed=Aria'},
  ];

  /// Get avatars by gender
  static List<Map<String, String>> getAvatarsByGender(bool isMale) {
    return isMale ? maleAvatars : femaleAvatars;
  }

  /// Get avatar URL by ID
  static String? getAvatarUrlById(String id) {
    final allAvatars = [...maleAvatars, ...femaleAvatars];
    final avatar = allAvatars.firstWhere(
      (a) => a['id'] == id,
      orElse: () => {},
    );
    return avatar['url'];
  }
}
