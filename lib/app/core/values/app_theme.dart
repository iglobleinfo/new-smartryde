import 'package:flutter/cupertino.dart';
import 'package:smart_ryde/export.dart';


class ThemeConfig {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color background,
    required Color primaryText,
    Color? secondaryText,
    required Color accentColor,
    Color? divider,
    Color? buttonBackground,
    required Color buttonText,
    Color? cardBackground,
    Color? disabled,
    required Color error,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      brightness: brightness,
      canvasColor: background,
      primaryColorDark: Colors.red,
      cardColor: background,
      dividerColor: divider,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }),
      dividerTheme: DividerThemeData(
        color: divider,
        space: 1,
        thickness: 1,
      ),
      // cardTheme: CardTheme(
      //   color: cardBackground,
      //   margin: EdgeInsets.zero,
      //   clipBehavior: Clip.antiAliasWithSaveLayer,
      // ),
      primaryColor: accentColor,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorAppColor,
        selectionColor: Colors.orange.shade50,
        selectionHandleColor: colorAppColor,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarBrightness: brightness),
        color: Colors.black,
        toolbarTextStyle: TextStyle(
          color: secondaryText,
          fontSize: 18.0.sp,
        ),
        iconTheme: IconThemeData(color: colorAppColor, size: height_25),
      ),
      iconTheme: IconThemeData(
        color: colorAppColor,
        size: height_25,
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: Colors.purple,
          primaryContainer: accentColor,
          secondary: accentColor,
          secondaryContainer: accentColor,
          surface: background,
          error: error,
          onPrimary: buttonText,
          onSecondary: buttonText,
          onSurface: buttonText,
          onError: buttonText,
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: accentColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: colorAppColor, width: 1.5),
        ),
        errorStyle: TextStyle(color: error),
        labelStyle: TextStyle(
          fontFamily: FontFamily.mazzard,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: primaryText.withValues(alpha: 0.5),
        ),
      ),
      fontFamily: FontFamily.mazzard,
      unselectedWidgetColor: Colors.grey,
      textTheme: TextTheme(
        displayLarge: baseTextTheme.displayLarge?.copyWith(
          color: primaryText,
          fontSize: font_22,
          fontFamily: "Urbanist",
          fontWeight: FontWeight.w700,
        ),
        displayMedium: baseTextTheme.displayMedium?.copyWith(
          color: primaryText,
          fontSize: font_18,
          fontFamily: "Urbanist",
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          color: primaryText,
          fontSize: font_16,
          fontFamily: "Urbanist",
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          color: primaryText,
          fontSize: font_14,
          fontFamily: "Urbanist",
          fontWeight: FontWeight.w500,
        ),
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          color: primaryText,
          fontSize: font_16,
          fontWeight: FontWeight.w600,
        ),
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          color: primaryText,
          fontSize: font_10,
          fontWeight: FontWeight.w300,
        ),
        labelSmall: baseTextTheme.labelSmall?.copyWith(
          color: secondaryText,
          fontSize: font_11,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          color: primaryText,
          fontSize: font_14,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: baseTextTheme.titleSmall?.copyWith(
          color: secondaryText,
          fontSize: font_12,
          fontWeight: FontWeight.w400,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return accentColor;
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return accentColor;
          }
          return null;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return accentColor;
          }
          return null;
        }),
        trackColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return null;
          }
          if (states.contains(WidgetState.selected)) {
            return accentColor;
          }
          return null;
        }),
      ),
      colorScheme: ColorScheme.fromSwatch(
              accentColor: accentColor, brightness: brightness)
          .copyWith(primary: Colors.red, surface: background)
          .copyWith(error: error),
    );
  }

  static ThemeData get lightTheme => createTheme(
        brightness: Brightness.light,
        background: Colors.white,
        cardBackground: Colors.white,
        primaryText: Colors.black,
        secondaryText: Colors.black,
        accentColor: colorAppColor,
        divider: colorAppColor,
        buttonBackground: Colors.black38,
        buttonText: colorAppColor,
        disabled: colorAppColor,
        error: Colors.red,
      );

  static ThemeData get darkTheme => createTheme(
        brightness: Brightness.dark,
        background: Colors.black,
        cardBackground: colorAppColor,
        primaryText: Colors.white,
        secondaryText: Colors.black,
        accentColor: Colors.transparent,
        divider: Colors.black45,
        buttonBackground: Colors.white,
        buttonText: colorAppColor,
        disabled: colorAppColor,
        error: Colors.red,
      );
}
