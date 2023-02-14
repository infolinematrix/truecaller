import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  // visualDensity: VisualDensity(vertical: 0.5.h, horizontal: 0.5.w),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'ROBOTO',

  canvasColor: Colors.white,
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  cardColor: const Color(0xFFFFFFFF),
  dividerColor: Colors.grey.shade100,

  // splashFactory: InkSplash.splashFactory,
  // focusColor: Colors.redAccent,
  // hoverColor: Colors.redAccent,
  // highlightColor: Colors.green,
  // dialogBackgroundColor: Colors.white,
  // indicatorColor: Colors.redAccent,
  // hintColor: Colors.grey,
  // secondaryHeaderColor: Colors.grey,
  // unselectedWidgetColor: Colors.grey.shade400,
  // disabledColor: Colors.grey.shade200,
  // buttonTheme: const ButtonThemeData(
  //   textTheme: ButtonTextTheme.primary,
  //   colorScheme: ColorScheme.light(
  //     primary: Color(0xff457BE0),
  //     secondary: Color(0xBFFFFDDD),
  //     brightness: Brightness.light,
  //     background: Color(0xffB5BFD3),
  //     error: Colors.red,
  //     onBackground: Color(0xffB5BFD3),
  //     onError: Colors.red,
  //     onPrimary: Color(0xFFFFFFFF),
  //     onSecondary: Color(0xff457BE0),
  //     onSurface: Color(0xff457BE0),
  //     surface: Color(0xff457BE0),
  //   ),
  // ),
  // toggleButtonsTheme: const ToggleButtonsThemeData(),
  // textTheme: const TextTheme(),
  // primaryTextTheme: const TextTheme(),

  // listTileTheme: const ListTileThemeData(
  //   tileColor: Colors.white,
  // ),

  // cardTheme: const CardTheme(color: Colors.white),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    floatingLabelStyle: TextStyle(color: Colors.black54, fontSize: 13.0.sp),
    labelStyle: TextStyle(color: Colors.black54, fontSize: 13.0.sp),
    contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
    errorStyle: const TextStyle(
      color: Colors.transparent,
      fontSize: 0.001,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red.shade100, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
    ),
  ),

  // iconTheme: const IconThemeData(color: Colors.black),
  // primaryIconTheme: const IconThemeData(color: Colors.black),
  // sliderTheme: const SliderThemeData(),
  // tabBarTheme: const TabBarTheme(),
  // tooltipTheme: const TooltipThemeData(),
  // cardTheme: const CardTheme(color: Colors.white),
  // chipTheme: const ChipThemeData(
  //   backgroundColor: Color(0xff936F3E),
  //   disabledColor: Color(0xaaF5E0C3),
  //   shape: StadiumBorder(),
  //   brightness: Brightness.light,
  //   labelPadding: EdgeInsets.all(8),
  //   labelStyle: TextStyle(),
  //   padding: EdgeInsets.all(8),
  //   secondaryLabelStyle: TextStyle(),
  //   secondarySelectedColor: Colors.white38,
  //   selectedColor: Colors.white,
  // ),
  // platform: TargetPlatform.android,
  // materialTapTargetSize: MaterialTapTargetSize.padded,
  // applyElevationOverlayColor: true,

  appBarTheme: AppBarTheme(
    centerTitle: false,
    elevation: 0,
    surfaceTintColor: Colors.white,
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: 16.0.sp,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2.sp,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  ),

  textTheme: textTheme,

  // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
  //     .copyWith(background: const Color(0xff457BE0))
  //     .copyWith(error: Colors.red),
);

final dateStyle = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
  primary: Colors.blueAccent,
));

final textTheme = TextTheme(
  displayLarge: GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 57.sp,
    height: 64 / 57,
    letterSpacing: -0.25,
  ),
  displayMedium: GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 45.sp,
    height: 52 / 45,
  ),
  displaySmall: GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 36.sp,
    height: 44 / 36,
  ),
  headlineLarge: GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 32.sp,
    height: 40 / 32,
  ),
  headlineMedium: GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 28.sp,
    height: 36 / 28,
  ),
  headlineSmall: GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 24.sp,
    height: 32 / 24,
  ),
  titleLarge: GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 18.sp,
    height: 28 / 22,
  ),
  titleMedium: GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    height: 24 / 16,
    letterSpacing: 0.1,
  ),
  titleSmall: GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
    height: 20 / 14,
    letterSpacing: 0.1,
  ),
  labelLarge: GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 14.sp,
    height: 20 / 14,
  ),
  labelMedium: GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 12.sp,
    height: 16 / 12,
  ),
  labelSmall: GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 11.sp,
    height: 16 / 11,
  ),
  bodyLarge: GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    height: 24 / 16,
  ),
  bodyMedium: GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 13.sp,
    height: 20 / 14,
  ),
  bodySmall: GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    height: 16 / 12,
  ),
);
// /// DARK THEME
// ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
//     primaryColor: const Color(0xff5D4524),
//     primaryColorLight: const Color(0x1a311F06),
//     primaryColorDark: const Color(0xff936F3E),
//     canvasColor: const Color(0xffE09E45),
//     scaffoldBackgroundColor: const Color(0xffB5BFD3),
//     cardColor: const Color(0xaa311F06),
//     dividerColor: const Color(0x1f6D42CE),
//     focusColor: const Color(0x1a311F06),
//     hoverColor: const Color(0xa15D4524),
//     highlightColor: const Color(0xaf2F1E06),
//     splashColor: const Color(0xff457BE0),
//     unselectedWidgetColor: Colors.grey.shade400,
//     disabledColor: Colors.grey.shade200,
//     buttonTheme: const ButtonThemeData(
// //button themes
//         ),
//     toggleButtonsTheme: const ToggleButtonsThemeData(
// //toggle button theme
//         ),
//     secondaryHeaderColor: Colors.grey,
//     dialogBackgroundColor: Colors.white,
//     indicatorColor: const Color(0xff457BE0),
//     hintColor: Colors.grey,
//     textTheme: const TextTheme(
// //text themes that contrast with card and canvas
//         ),
//     primaryTextTheme: const TextTheme(
// //text theme that contrast with primary color
//         ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: Colors.transparent,
//       errorStyle: const TextStyle(
//         color: Colors.transparent,
//         fontSize: 0.001,
//       ),
//       errorBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.red.shade100, width: 1.0),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
//       ),
//     ),
//     iconTheme: const IconThemeData(
// //icon themes that contrast with card and canvas
//         ),
//     primaryIconTheme: const IconThemeData(
// //icon themes that contrast primary color
//         ),
//     sliderTheme: const SliderThemeData(
//         // slider themes
//         ),
//     tabBarTheme: const TabBarTheme(
//         // tab bat theme
//         ),
//     tooltipTheme: const TooltipThemeData(
//         // tool tip theme
//         ),
//     cardTheme: const CardTheme(
//         // card theme
//         ),
//     chipTheme: const ChipThemeData(
//         backgroundColor: Color(0xff2F1E06),
//         disabledColor: Color(0xa15D4524),
//         shape: StadiumBorder(),
//         brightness: Brightness.dark,
//         labelPadding: EdgeInsets.all(8),
//         labelStyle: TextStyle(),
//         padding: EdgeInsets.all(8),
//         secondaryLabelStyle: TextStyle(),
//         secondarySelectedColor: Colors.white38,
//         selectedColor: Colors.white
//         // chip theme
//         ),
//     platform: TargetPlatform.android,
//     materialTapTargetSize: MaterialTapTargetSize.padded,
//     applyElevationOverlayColor: true,
//     pageTransitionsTheme: const PageTransitionsTheme(
//         //page transition theme
//         ),
//     appBarTheme: const AppBarTheme(
//         //app bar theme
//         ),
//     bottomAppBarTheme: const BottomAppBarTheme(
//         // bottom app bar theme
//         ),
//     snackBarTheme: const SnackBarThemeData(
//         // snack bar theme
//         ),
//     dialogTheme: const DialogTheme(
//         // dialog theme
//         ),
//     floatingActionButtonTheme: const FloatingActionButtonThemeData(
//         // floating action button theme
//         ),
//     navigationRailTheme: const NavigationRailThemeData(
//         // navigation rail theme
//         ),
//     typography: Typography.material2021(),
//     cupertinoOverrideTheme: const CupertinoThemeData(
//         //cupertino theme
//         ),
//     bottomSheetTheme: const BottomSheetThemeData(
//         //bottom sheet theme
//         ),
//     popupMenuTheme: const PopupMenuThemeData(
//         //pop menu theme
//         ),
//     bannerTheme: const MaterialBannerThemeData(
//         // material banner theme
//         ),
//     dividerTheme: const DividerThemeData(
//         //divider, vertical divider theme
//         ),
//     buttonBarTheme: const ButtonBarThemeData(
//         // button bar theme
//         ),
//     fontFamily: 'ROBOTO',
//     splashFactory: InkSplash.splashFactory,
//     // bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xff6D42CE)),
//     switchTheme: SwitchThemeData(
//       thumbColor: MaterialStateProperty.resolveWith<Color?>(
//           (Set<MaterialState> states) {
//         if (states.contains(MaterialState.disabled)) {
//           return null;
//         }
//         if (states.contains(MaterialState.selected)) {
//           return const Color(0xff6D42CE);
//         }
//         return null;
//       }),
//       trackColor: MaterialStateProperty.resolveWith<Color?>(
//           (Set<MaterialState> states) {
//         if (states.contains(MaterialState.disabled)) {
//           return null;
//         }
//         if (states.contains(MaterialState.selected)) {
//           return const Color(0xff6D42CE);
//         }
//         return null;
//       }),
//     ),
//     radioTheme: RadioThemeData(
//       fillColor: MaterialStateProperty.resolveWith<Color?>(
//           (Set<MaterialState> states) {
//         if (states.contains(MaterialState.disabled)) {
//           return null;
//         }
//         if (states.contains(MaterialState.selected)) {
//           return const Color(0xff6D42CE);
//         }
//         return null;
//       }),
//     ),
//     checkboxTheme: CheckboxThemeData(
//       fillColor: MaterialStateProperty.resolveWith<Color?>(
//           (Set<MaterialState> states) {
//         if (states.contains(MaterialState.disabled)) {
//           return null;
//         }
//         if (states.contains(MaterialState.selected)) {
//           return const Color(0xff6D42CE);
//         }
//         return null;
//       }),
//     ),
//     colorScheme: const ColorScheme(
//             primary: Color(0xff5D4524),
//             secondary: Color(0xff457BE0),
//             brightness: Brightness.dark,
//             background: Color(0xffB5BFD3),
//             error: Colors.red,
//             onBackground: Color(0xffB5BFD3),
//             onError: Colors.red,
//             onPrimary: Color(0xff5D4524),
//             onSecondary: Color(0xff457BE0),
//             onSurface: Color(0xff457BE0),
//             surface: Color(0xff457BE0))
//         .copyWith(secondary: const Color(0xff457BE0))
//         .copyWith(background: const Color(0xff457BE0))
//         .copyWith(error: Colors.red));

/// CheckBox Decoration
InputDecoration checkBoxDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
  filled: true,
  fillColor: Colors.transparent,
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red.shade100, width: 1.0),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
  ),
);

TextStyle inputTextStyle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 13.0.sp,
);

//--ListTitle
TextStyle listTileTitle =
    TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.w700);
TextStyle listTileSubTitle = TextStyle(
    fontSize: 12.0.sp, fontWeight: FontWeight.w600, color: Colors.black54);
