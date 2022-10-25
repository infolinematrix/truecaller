import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
//   // primarySwatch: const MaterialColor(
//   //   0xff457BE0,
//   //   <int, Color>{
//   //     50: Color(0x1aF5E0C3),
//   //     100: Color(0xa1F5E0C3),
//   //     200: Color(0xaaF5E0C3),
//   //     300: Color(0xafF5E0C3),
//   //     400: Color(0xffF5E0C3),
//   //     500: Color(0xffEDD5B3),
//   //     600: Color(0xffDEC29B),
//   //     700: Color(0xffC9A87C),
//   //     800: Color(0xffB28E5E),
//   //     900: Color(0xff936F3E)
//   //   },
//   // ),
  primarySwatch: Colors.blue,
  splashColor: Colors.grey,
  primaryColor: const Color(0xFF212121),
  primaryColorLight: const Color(0x1aF5E0C3),
  primaryColorDark: const Color(0xff457BE0),
  canvasColor: Colors.white,

  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  bottomAppBarColor: const Color(0xffffffff),
  cardColor: const Color(0xaaF5E0C3),
  dividerColor: const Color(0x1f6D42CE),
  focusColor: const Color(0x1aF5E0C3),
  hoverColor: const Color(0xBD0D7BE0),
  highlightColor: const Color(0xFFe3f2fd),

  backgroundColor: const Color(0xff457BE0),
  dialogBackgroundColor: Colors.white,
  indicatorColor: const Color(0xffb3e5fc),
  hintColor: Colors.grey,
  errorColor: Colors.red,
  toggleableActiveColor: const Color(0xBD0D7BE0),
  secondaryHeaderColor: Colors.grey,

  selectedRowColor: Colors.grey,
  unselectedWidgetColor: Colors.grey.shade400,
  disabledColor: Colors.grey.shade200,
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    colorScheme: ColorScheme.light(
      primary: Color(0xff457BE0),
      secondary: Color(0xBFFFFDDD),
      brightness: Brightness.light,
      background: Color(0xffB5BFD3),
      error: Colors.red,
      onBackground: Color(0xffB5BFD3),
      onError: Colors.red,
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xff457BE0),
      onSurface: Color(0xff457BE0),
      surface: Color(0xff457BE0),
    ),
  ),
  toggleButtonsTheme: const ToggleButtonsThemeData(),
  textTheme: const TextTheme(),
  primaryTextTheme: const TextTheme(),
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
  iconTheme: const IconThemeData(color: Colors.black),
  primaryIconTheme: const IconThemeData(color: Colors.black),
  sliderTheme: const SliderThemeData(),
  tabBarTheme: const TabBarTheme(),
  tooltipTheme: const TooltipThemeData(),
  cardTheme: const CardTheme(color: Colors.white),
  chipTheme: const ChipThemeData(
      backgroundColor: Color(0xff936F3E),
      disabledColor: Color(0xaaF5E0C3),
      shape: StadiumBorder(),
      brightness: Brightness.light,
      labelPadding: EdgeInsets.all(8),
      labelStyle: TextStyle(),
      padding: EdgeInsets.all(8),
      secondaryLabelStyle: TextStyle(),
      secondarySelectedColor: Colors.white38,
      selectedColor: Colors.white
      // chip theme
      ),
  platform: TargetPlatform.android,
  materialTapTargetSize: MaterialTapTargetSize.padded,
  applyElevationOverlayColor: true,

  appBarTheme: AppBarTheme(
    //app bar theme
    backgroundColor: Colors.white,
    // foregroundColor: Colors.black,

    centerTitle: false,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 16.0.sp,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2.sp,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
      // bottom app bar theme
      ),
  snackBarTheme: const SnackBarThemeData(
      // snack bar theme
      ),
  dialogTheme: const DialogTheme(
      // dialog theme
      ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      // floating action button theme
      ),
  navigationRailTheme: const NavigationRailThemeData(
      // navigation rail theme
      ),
  typography: Typography.material2018(),
  cupertinoOverrideTheme: const CupertinoThemeData(
      //cupertino theme
      ),
  bottomSheetTheme: const BottomSheetThemeData(
      //bottom sheet theme
      ),
  popupMenuTheme: const PopupMenuThemeData(
      color: Colors.white, textStyle: TextStyle(color: Colors.black)
      //pop menu theme
      ),
  bannerTheme: const MaterialBannerThemeData(
      // material banner theme
      ),
  dividerTheme: const DividerThemeData(
      //divider, vertical divider theme
      ),
  buttonBarTheme: const ButtonBarThemeData(
      // button bar theme
      ),
  fontFamily: 'ROBOTO',
  splashFactory: InkSplash.splashFactory,
);

/// DARK THEME
ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
    primaryColor: const Color(0xff5D4524),
    primaryColorLight: const Color(0x1a311F06),
    primaryColorDark: const Color(0xff936F3E),
    canvasColor: const Color(0xffE09E45),
    scaffoldBackgroundColor: const Color(0xffB5BFD3),
    bottomAppBarColor: const Color(0xff6D42CE),
    cardColor: const Color(0xaa311F06),
    dividerColor: const Color(0x1f6D42CE),
    focusColor: const Color(0x1a311F06),
    hoverColor: const Color(0xa15D4524),
    highlightColor: const Color(0xaf2F1E06),
    splashColor: const Color(0xff457BE0),
//  splashFactory: # override create method from  InteractiveInkFeatureFactory
    selectedRowColor: Colors.grey,
    unselectedWidgetColor: Colors.grey.shade400,
    disabledColor: Colors.grey.shade200,
    buttonTheme: const ButtonThemeData(
//button themes
        ),
    toggleButtonsTheme: const ToggleButtonsThemeData(
//toggle button theme
        ),
    secondaryHeaderColor: Colors.grey,
    // textSelectionColor: Color(0x1a483112),
    // cursorColor: Color(0xff483112),
    // textSelectionHandleColor: Color(0xff483112),
    backgroundColor: const Color(0xff457BE0),
    dialogBackgroundColor: Colors.white,
    indicatorColor: const Color(0xff457BE0),
    hintColor: Colors.grey,
    errorColor: Colors.red,
    toggleableActiveColor: const Color(0xff6D42CE),
    textTheme: const TextTheme(
//text themes that contrast with card and canvas
        ),
    primaryTextTheme: const TextTheme(
//text theme that contrast with primary color
        ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
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
    ),
    iconTheme: const IconThemeData(
//icon themes that contrast with card and canvas
        ),
    primaryIconTheme: const IconThemeData(
//icon themes that contrast primary color
        ),
    sliderTheme: const SliderThemeData(
        // slider themes
        ),
    tabBarTheme: const TabBarTheme(
        // tab bat theme
        ),
    tooltipTheme: const TooltipThemeData(
        // tool tip theme
        ),
    cardTheme: const CardTheme(
        // card theme
        ),
    chipTheme: const ChipThemeData(
        backgroundColor: Color(0xff2F1E06),
        disabledColor: Color(0xa15D4524),
        shape: StadiumBorder(),
        brightness: Brightness.dark,
        labelPadding: EdgeInsets.all(8),
        labelStyle: TextStyle(),
        padding: EdgeInsets.all(8),
        secondaryLabelStyle: TextStyle(),
        secondarySelectedColor: Colors.white38,
        selectedColor: Colors.white
        // chip theme
        ),
    platform: TargetPlatform.android,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    applyElevationOverlayColor: true,
    pageTransitionsTheme: const PageTransitionsTheme(
        //page transition theme
        ),
    appBarTheme: const AppBarTheme(
        //app bar theme
        ),
    bottomAppBarTheme: const BottomAppBarTheme(
        // bottom app bar theme
        ),
    snackBarTheme: const SnackBarThemeData(
        // snack bar theme
        ),
    dialogTheme: const DialogTheme(
        // dialog theme
        ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        // floating action button theme
        ),
    navigationRailTheme: const NavigationRailThemeData(
        // navigation rail theme
        ),
    typography: Typography.material2018(),
    cupertinoOverrideTheme: const CupertinoThemeData(
        //cupertino theme
        ),
    bottomSheetTheme: const BottomSheetThemeData(
        //bottom sheet theme
        ),
    popupMenuTheme: const PopupMenuThemeData(
        //pop menu theme
        ),
    bannerTheme: const MaterialBannerThemeData(
        // material banner theme
        ),
    dividerTheme: const DividerThemeData(
        //divider, vertical divider theme
        ),
    buttonBarTheme: const ButtonBarThemeData(
        // button bar theme
        ),
    colorScheme: const ColorScheme(
            primary: Color(0xff5D4524),
            secondary: Color(0xff457BE0),
            brightness: Brightness.dark,
            background: Color(0xffB5BFD3),
            error: Colors.red,
            onBackground: Color(0xffB5BFD3),
            onError: Colors.red,
            onPrimary: Color(0xff5D4524),
            onSecondary: Color(0xff457BE0),
            onSurface: Color(0xff457BE0),
            surface: Color(0xff457BE0))
        .copyWith(secondary: const Color(0xff457BE0)),
    fontFamily: 'ROBOTO',
    splashFactory: InkSplash.splashFactory);

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
  fontWeight: FontWeight.w500,
  fontSize: 14.0.sp,
);
