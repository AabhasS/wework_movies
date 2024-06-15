extension Shortner on num {
  String toShortString() {
    if (this >= 1000000000) {
      return '${(this / 1000000000).toStringAsFixed(1)}B';
    } else if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}k';
    } else {
      return toStringAsFixed(0);
    }
  }
}

extension LocaleExtensions on String {
  static const Map<String, String> _localeToLanguage = {
    'en': 'English',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'it': 'Italian',
    'ja': 'Japanese',
    'ko': 'Korean',
    'zh': 'Chinese',
    // Add more locales as needed
  };

  String toLanguageName() {
    return _localeToLanguage[this] ?? 'Unknown';
  }
}