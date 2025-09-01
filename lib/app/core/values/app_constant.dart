enum ViewType { bottomNav, drawer }

const String appLoginSignUpKey = 'Bearer bd14ad81-76e2-4a66-9a21-b4d4a64f82be';

enum Language {
  en,
  sch,
  tch,
}

// for local purpose
Language languageFromString(String value) {
  switch (value) {
    case 'en':
      return Language.en;
    case 'sch':
      return Language.sch;
    case 'tch':
      return Language.tch;
    default:
      return Language.en; // default fallback
  }
}

// for Api purpose
Language languageFromApi(String value) {
  switch (value) {
    case 'ENG':
      return Language.en;
    case 'SCH':
      return Language.sch;
    case 'TCH':
      return Language.tch;
    default:
      return Language.en; // default fallback
  }
}

String stringFromLanguage(Language value) {
  switch (value) {
    case Language.en:
      return 'ENG';
    case Language.sch:
      return 'SCH';
    case Language.tch:
      return 'TCH';
  }
}
