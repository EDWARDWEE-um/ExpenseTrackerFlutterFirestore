part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  final ThemeType themeType;
  final ColorTheme colorTheme;
  final ThemeData themeData;

  const ThemeState({
    required this.themeType,
    required this.colorTheme,
    required this.themeData,
  });

  factory ThemeState.initial({
    required ThemeType? themeType,
  }) {
    switch (themeType) {
      case ThemeType.darkTheme:
        return DarkThemeState.initial();
      default:
        return DefaultThemeState.initial();
    }
  }

  @override
  List<Object> get props => [
        themeType,
      ];
}

class DefaultThemeState extends ThemeState {
  const DefaultThemeState._({
    required ColorTheme colorTheme,
    required ThemeData themeData,
  }) : super(
          themeType: ThemeType.defaultTheme,
          themeData: themeData,
          colorTheme: colorTheme,
        );

  factory DefaultThemeState.initial() {
    const colorTheme = ColorTheme(
      primaryColor: Color.fromARGB(255, 235, 114, 16),
      primaryVariantColor: Color(0xFFE69A5D),
      secondaryColor: Color(0xFFF4F4F4),
      secondaryVariantColor: Color(0xFFFFEFEF),
      surfaceColor: Colors.white,
      backgroundColor: Colors.white,
      backgroundGradientColor: Color(0xFFFFFCD7),
      errorColor: Colors.red,
      onPrimaryColor: Colors.white,
      onSecondaryColor: Colors.black,
      onSurfaceColor: Colors.black,
      onBackgroundColor: Colors.black,
      onErrorColor: Colors.white,
      individualColor: Color(0xFF2580EC),
      businessCorporationColor: Color(0xFFAC712D),
      charitableOrganizationColor: Color(0xFFC14B42),
      secondaryBackgroundColor: Color(0xFFFDF8EF),
      onSecondaryBackgroundColor: Colors.white,
      liveButtonColor: Color(0xFFFDF7A6),
      imagePickerBtnColor: Color(0xFFD9EDDB),
      postButtonColor: Color(0xFFE69A5D),
    );

    final textTheme = _createTextThemeFromTemplate(colorTheme);

    final themeData = _createThemeDataFromTemplate(
      colorTheme: colorTheme,
      textTheme: textTheme,
    );

    return DefaultThemeState._(
      colorTheme: colorTheme,
      themeData: themeData,
    );
  }

  @override
  List<Object> get props => super.props..addAll([]);
}

class DarkThemeState extends ThemeState {
  const DarkThemeState._({
    required ColorTheme colorTheme,
    required ThemeData themeData,
  }) : super(
          themeType: ThemeType.darkTheme,
          themeData: themeData,
          colorTheme: colorTheme,
        );

  factory DarkThemeState.initial() {
    const colorTheme = ColorTheme(
      primaryColor: Color.fromARGB(255, 235, 114, 16),
      primaryVariantColor: Color(0xFFE69A5D),
      secondaryColor: Color(0xFFF4F4F4),
      secondaryVariantColor: Color(0xFFFFEFEF),
      surfaceColor: Colors.white,
      backgroundColor: Colors.black,
      backgroundGradientColor: Color(0xFFFFFCD7),
      errorColor: Colors.red,
      onPrimaryColor: Colors.white,
      onSecondaryColor: Colors.black,
      onSurfaceColor: Colors.black,
      onBackgroundColor: Colors.white,
      onErrorColor: Colors.white,
      individualColor: Color(0xFF2580EC),
      businessCorporationColor: Color(0xFFAC712D),
      charitableOrganizationColor: Color(0xFFC14B42),
      secondaryBackgroundColor: Color(0xFFFDF8EF),
      onSecondaryBackgroundColor: Colors.white,
      liveButtonColor: Color(0xFFFDF7A6),
      imagePickerBtnColor: Color(0xFFD9EDDB),
      postButtonColor: Color(0xFFE69A5D),
    );

    final textTheme = _createTextThemeFromTemplate(colorTheme);

    final themeData = _createThemeDataFromTemplate(
        colorTheme: colorTheme, textTheme: textTheme);

    return DarkThemeState._(
      colorTheme: colorTheme,
      themeData: themeData,
    );
  }

  @override
  List<Object> get props => super.props..addAll([]);

  ThemeState changeLanguage() {
    return DarkThemeState._(
      colorTheme: colorTheme,
      themeData: themeData,
    );
  }
}

///when define new color then add in here
///so we ensure every theme have same color attribute
class ColorTheme {
  final Color primaryColor;
  final Color primaryVariantColor;
  final Color secondaryColor;
  final Color secondaryVariantColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color backgroundGradientColor;
  final Color errorColor;
  final Color onPrimaryColor;
  final Color onSecondaryColor;
  final Color onSurfaceColor;
  final Color onBackgroundColor;
  final Color onErrorColor;
  final Color individualColor;
  final Color businessCorporationColor;
  final Color charitableOrganizationColor;
  final Color secondaryBackgroundColor;
  final Color onSecondaryBackgroundColor;
  final Color liveButtonColor;
  final Color imagePickerBtnColor;
  final Color postButtonColor;

  const ColorTheme({
    required this.primaryColor,
    required this.primaryVariantColor,
    required this.secondaryColor,
    required this.secondaryVariantColor,
    required this.surfaceColor,
    required this.backgroundColor,
    required this.backgroundGradientColor,
    required this.errorColor,
    required this.onPrimaryColor,
    required this.onSecondaryColor,
    required this.onSurfaceColor,
    required this.onBackgroundColor,
    required this.onErrorColor,
    required this.individualColor,
    required this.businessCorporationColor,
    required this.charitableOrganizationColor,
    required this.secondaryBackgroundColor,
    required this.onSecondaryBackgroundColor,
    required this.liveButtonColor,
    required this.imagePickerBtnColor,
    required this.postButtonColor,
  });

  ColorScheme toColorScheme({
    Brightness brightness = Brightness.light,
  }) {
    return ColorScheme(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      background: backgroundColor,
      error: errorColor,
      onPrimary: onPrimaryColor,
      onSecondary: onSecondaryColor,
      onSurface: onSurfaceColor,
      onBackground: onBackgroundColor,
      onError: onErrorColor,
      brightness: brightness,
      primaryVariant: primaryColor,
      secondaryVariant: secondaryColor,
    );
  }
}

TextTheme _createTextThemeFromTemplate(
  ColorTheme colorTheme, {
  TextStyle? headline2,
  TextStyle? headline3,
  TextStyle? headline4,
  TextStyle? headline5,
  TextStyle? headline6,
  TextStyle? subtitle1,
  TextStyle? subtitle2,
  TextStyle? bodyText1,
  TextStyle? bodyText2,
  TextStyle? button,
  TextStyle? caption,
}) {
  return TextTheme(
    headline2: headline2 ??
        TextStyle(
          fontSize: headline2FontSize,
          fontWeight: headline2FontWeight,
          color: colorTheme.onBackgroundColor,
        ),
    headline3: headline3 ??
        TextStyle(
          fontSize: headline3FontSize,
          fontWeight: headline3FontWeight,
          color: colorTheme.onBackgroundColor,
        ),
    headline4: headline4 ??
        TextStyle(
          fontSize: headline4FontSize,
          fontWeight: headline4FontWeight,
          color: colorTheme.onBackgroundColor,
        ),
    headline5: headline5 ??
        TextStyle(
          fontSize: headline5FontSize,
          fontWeight: headline5FontWeight,
          color: colorTheme.onBackgroundColor,
        ),
    headline6: headline6 ??
        TextStyle(
          fontSize: headline6FontSize,
          fontWeight: headline6FontWeight,
          color: colorTheme.onBackgroundColor,
        ),
    subtitle1: subtitle1 ??
        TextStyle(
          fontSize: subtitle1FontSize,
          fontWeight: subtitle1FontWeight,
          color: colorTheme.onBackgroundColor,
        ),
    subtitle2: subtitle2 ??
        TextStyle(
          fontSize: subtitle2FontSize,
          fontWeight: subtitle2FontWeight,
          color: colorTheme.onBackgroundColor.withOpacity(opacityMed),
        ),
    bodyText1: bodyText1 ??
        TextStyle(
          fontSize: bodyText1FontSize,
          fontWeight: bodyText1FontWeight,
          color: colorTheme.onBackgroundColor,
        ),
    bodyText2: bodyText2 ??
        TextStyle(
          fontSize: bodyText2FontSize,
          fontWeight: bodyText2FontWeight,
          color: colorTheme.onBackgroundColor.withOpacity(opacityHigh),
        ),
    button: button ??
        TextStyle(
          fontSize: buttonFontSize,
          fontWeight: buttonFontWeight,
          color: colorTheme.onPrimaryColor,
        ),
    caption: caption ??
        TextStyle(
          fontSize: captionFontSize,
          fontWeight: captionFontWeight,
          color: colorTheme.onBackgroundColor.withOpacity(opacityMed),
        ),
  );
}

ThemeData _createThemeDataFromTemplate({
  required ColorTheme colorTheme,
  required TextTheme textTheme,
  String fontFamily = 'Montserrat',
  InputDecorationTheme? inputDecorationTheme,
  AppBarTheme? appBarTheme,
  BottomNavigationBarThemeData? bottomNavigationBarTheme,
  IconThemeData? iconTheme,
  TextButtonThemeData? textButtonTheme,
  OutlinedButtonThemeData? outlinedButtonTheme,
  DividerThemeData? dividerThemeData,
  Brightness brightness = Brightness.light,
}) {
  final colorScheme = colorTheme.toColorScheme(brightness: brightness);

  const outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
  );

  return ThemeData(
    primaryColor: colorTheme.primaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: colorTheme.backgroundColor,
    fontFamily: fontFamily,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorTheme.primaryColor,
      foregroundColor: colorTheme.onPrimaryColor,
    ),
    appBarTheme: appBarTheme ??
        AppBarTheme(
          elevation: 0.0,
          centerTitle: false,
          iconTheme: IconThemeData(
            color: colorTheme.onBackgroundColor,
          ),
          backgroundColor: colorTheme.backgroundColor,
          toolbarTextStyle: TextTheme(
            headline5: textTheme.headline5!.copyWith(
              color: colorTheme.onBackgroundColor,
            ),
          ).bodyText2,
          titleTextStyle: TextTheme(
            headline5: textTheme.headline5!.copyWith(
              color: colorTheme.onBackgroundColor,
            ),
          ).headline6,
        ),
    bottomNavigationBarTheme: bottomNavigationBarTheme ??
        BottomNavigationBarThemeData(
            elevation: 0.0,
            selectedIconTheme: IconThemeData(
              color: colorTheme.onBackgroundColor,
            ),
            unselectedIconTheme: IconThemeData(
              color: colorTheme.onBackgroundColor,
            ),
            backgroundColor: colorTheme.backgroundColor,
            selectedItemColor: colorTheme.onBackgroundColor),
    iconTheme: iconTheme ?? const IconThemeData(size: defaultIconSize),
    textButtonTheme: textButtonTheme ??
        TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: colorTheme.onBackgroundColor.withOpacity(opacityMed),
          ),
        ),
    outlinedButtonTheme: outlinedButtonTheme ??
        OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: colorTheme.primaryColor,
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(
                horizontal: spaceXLarge, vertical: spaceXMid),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(circularRadius),
            ),
            side: BorderSide(
              color: colorTheme.primaryColor,
              width: outlineBtnWidth,
            ),
          ),
        ),
    inputDecorationTheme: inputDecorationTheme ??
        InputDecorationTheme(
          isDense: true,
          filled: true,
          fillColor: colorTheme.secondaryColor,
          labelStyle:
              textTheme.subtitle2!.copyWith(color: colorTheme.onSecondaryColor),
          hintStyle: textTheme.subtitle2!.copyWith(
            color: colorTheme.onSecondaryColor.withOpacity(
              opacityMed,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: spaceXMid, horizontal: spaceLarge),
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          errorBorder: outlineInputBorder,
          focusedErrorBorder: outlineInputBorder,
          disabledBorder: outlineInputBorder,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
    dividerTheme: dividerThemeData ??
        DividerThemeData(
          space: defaultDividerSpace,
          thickness: defaultDividerThickness,
          color: colorTheme.onBackgroundColor.withOpacity(opacityLow),
        ),
    cardTheme: const CardTheme(elevation: defaultCardElevation),
    dialogTheme: DialogTheme(
      titleTextStyle: textTheme.headline5,
      contentTextStyle: textTheme.bodyText2,
      backgroundColor: colorTheme.backgroundColor,
    ),
    textTheme: textTheme,
    colorScheme: colorScheme,
  );
}
