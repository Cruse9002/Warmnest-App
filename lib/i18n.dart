import 'package:flutter/widgets.dart';
import 'package:warmnest/app_state.dart';

class I18n {
  static const Map<String, Map<String, String>> _strings = {
    'en': {
      'app.title': 'WarmNest',
      'login.email': 'Email',
      'login.name': 'Name',
      'login.continue': 'Continue',
      'onboarding.title': 'Onboarding',
      'onboarding.tellUs': 'Tell us a bit about you',
      'profile.title': 'Profile',
      'profile.save': 'Save',
      'profile.signOut': 'Sign Out',
      'dashboard.welcome': 'Welcome',
      'dashboard.howAreYou': 'How are you feeling today?',
      'dashboard.quickActions': 'Quick Actions',
      'dashboard.recentMood': 'Recent Mood',
    },
    'ta': {
      'app.title': 'வார்ம்நெஸ்ட்',
      'login.email': 'மின்னஞ்சல்',
      'login.name': 'பெயர்',
      'login.continue': 'தொடரவும்',
      'onboarding.title': 'தொடக்க அமைப்பு',
      'onboarding.tellUs': 'உங்களைப் பற்றி சொல்லுங்கள்',
      'profile.title': 'சுயவிவரம்',
      'profile.save': 'சேமி',
      'profile.signOut': 'வெளியேறு',
      'dashboard.welcome': 'வரவேற்கிறோம்',
      'dashboard.howAreYou': 'இன்று எப்படி உணர்கிறீர்கள்?',
      'dashboard.quickActions': 'விரைவு செயல்கள்',
      'dashboard.recentMood': 'சமீபத்திய மனநிலை',
    },
  };

  static String t(BuildContext context, String key) {
    final lang = AppStateProvider.of(context).language;
    final map = _strings[lang] ?? _strings['en']!;
    return map[key] ?? key;
  }
}


