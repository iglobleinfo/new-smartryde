enum ViewType { bottomNav, drawer }

const String appLoginSignUpKey = 'Bearer bd14ad81-76e2-4a66-9a21-b4d4a64f82be';

enum Language {
  en,
  sch,
  tch,
}

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
