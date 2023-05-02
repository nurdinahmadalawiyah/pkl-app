import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// colors
const Color backgroundColor = Color(0xFFFFFFFF);
const Color primaryColor = Color(0xFF11999E);
const Color secondaryColor = Color(0xFF30E3CA);
const Color tertiaryColor = Color(0xFF40514E);
const Color greyColor = Color(0xFFF2F6FB);
const Color blackColor = Color(0xFF000000);
const Color accentColor = Color(0xFFF2F6FB);

// text styles
final TextStyle kThin = GoogleFonts.poppins(fontWeight: FontWeight.w100);
final TextStyle kExtraLight = GoogleFonts.poppins(fontWeight: FontWeight.w200);
final TextStyle kLight = GoogleFonts.poppins(fontWeight: FontWeight.w300);
final TextStyle kRegular = GoogleFonts.poppins(fontWeight: FontWeight.w400);
final TextStyle kMedium = GoogleFonts.poppins(fontWeight: FontWeight.w500);
final TextStyle kSemiBold = GoogleFonts.poppins(fontWeight: FontWeight.w600);
final TextStyle kBold = GoogleFonts.poppins(fontWeight: FontWeight.w700);
final TextStyle kExtraBold = GoogleFonts.poppins(fontWeight: FontWeight.w800);
final TextStyle kBlack = GoogleFonts.poppins(fontWeight: FontWeight.w900);

// text theme
final kTextTheme = TextTheme(
  headlineSmall: kSemiBold,
  titleLarge: kMedium,
  titleMedium: kRegular,
  bodyMedium: kLight,
);
// box shadows
var boxShadow = BoxShadow(
  color: const Color(0xFFF2F6FB).withOpacity(0.3),
  spreadRadius: 0,
  blurRadius: 40,
  offset: const Offset(0, 4), // changes position of shadow
);

ColorScheme kColorScheme = const ColorScheme(
  primary: primaryColor,
  primaryContainer: primaryColor,
  secondary: secondaryColor,
  secondaryContainer: secondaryColor,
  surface: backgroundColor,
  background: backgroundColor,
  error: Colors.red,
  onPrimary: backgroundColor,
  onSecondary: Colors.white,
  onSurface: blackColor,
  onBackground: accentColor,
  onError: Colors.white,
  brightness: Brightness.light,
);