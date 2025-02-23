// lib/app/translations/translation_keys.dart
class TranslationKeys {
  // Define all translation keys as static constants
  static const String hello = 'hello';
  static const String welcomeMessage = 'welcome_message';
  static const String changeLanguage = 'change_language';
  static const String settings = 'settings';
  static const String profile = 'profile';
  static const String fastingTime = 'fasting_time';
  static const String iftarTime = 'iftar_time';
  static const String sehriTime = 'sehri_time';
  static const String prayerTimes = 'prayer_times';
  static const String trackPrayers = 'track_prayers';
  static const String trackFasting = 'track_fasting';
}

// lib/app/translations/bn_BD/bn_bd_translations.dart
final Map<String, String> bnBd = {
  TranslationKeys.hello: 'স্বাগতম',
  TranslationKeys.welcomeMessage: 'রমাদান ট্র্যাকারে স্বাগতম',
  TranslationKeys.changeLanguage: 'ভাষা পরিবর্তন করুন',
  TranslationKeys.settings: 'সেটিংস',
  TranslationKeys.profile: 'প্রোফাইল',
  TranslationKeys.fastingTime: 'রোজার সময়',
  TranslationKeys.iftarTime: 'ইফতারের সময়',
  TranslationKeys.sehriTime: 'সেহরির সময়',
  TranslationKeys.prayerTimes: 'নামাজের সময়',
  TranslationKeys.trackPrayers: 'নামাজ ট্র্যাক করুন',
  TranslationKeys.trackFasting: 'রোজা ট্র্যাক করুন',
};

// lib/app/translations/en_US/en_us_translations.dart
final Map<String, String> enUs = {
  TranslationKeys.hello: 'Hello',
  TranslationKeys.welcomeMessage: 'Welcome to Ramadan Tracker',
  TranslationKeys.changeLanguage: 'Change Language',
  TranslationKeys.settings: 'Settings',
  TranslationKeys.profile: 'Profile',
  TranslationKeys.fastingTime: 'Fasting Time',
  TranslationKeys.iftarTime: 'Iftar Time',
  TranslationKeys.sehriTime: 'Sehri Time',
  TranslationKeys.prayerTimes: 'Prayer Times',
  TranslationKeys.trackPrayers: 'Track Prayers',
  TranslationKeys.trackFasting: 'Track Fasting',
};
