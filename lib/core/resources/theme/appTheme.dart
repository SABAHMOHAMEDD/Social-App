import '../../core.dart';

class AppTheme {
  static final Color primaryColor = Colors.black;
  static final ThemeData LightTheme = ThemeData(
    scaffoldBackgroundColor: KSecondryColor,
    backgroundColor: Colors.white,
    fontFamily: 'j',
    primaryColor: Colors.black,
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        iconTheme: IconThemeData(color: Colors.black, size: 32),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
            fontFamily: 'j',
            fontSize: 24,
            color: Colors.redAccent,
            fontWeight: FontWeight.bold)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(color: Colors.black),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        selectedItemColor: Colors.black
        //El line daaaaaa
        ,
        unselectedItemColor: Colors.grey),
    textTheme: const TextTheme(
        subtitle1: TextStyle(
      color: Colors.black,
      fontSize: 14,
      height: 1.3,
      // fontWeight: FontWeight.w600
    )),
  );

  static final ThemeData DarkTheme = ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: KSecondryColor,
    backgroundColor: Colors.black12,
    fontFamily: 'j',
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        iconTheme: IconThemeData(color: Colors.white, size: 32),
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(color: Colors.white),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        selectedLabelStyle: TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.white),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white //El line daaaaaa

        ),
    textTheme: const TextTheme(
        subtitle1: TextStyle(
      color: Colors.white,
      fontSize: 14,
      height: 1.3,
      // fontWeight: FontWeight.w600
    )),
  );
}
