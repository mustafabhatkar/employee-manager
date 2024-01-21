import 'package:employee_manager/ui/screens/home_page.dart';
import 'package:employee_manager/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final myTheme = ThemeData(useMaterial3: false);
  final themeBlue = const Color(0xff1DA1F2);
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appTitle,
      theme: myTheme.copyWith(
          colorScheme: myTheme.colorScheme.copyWith(
              background: const Color(0xffF2F2F2),
              primary: themeBlue,
              secondary: themeBlue),
          textTheme: GoogleFonts.robotoTextTheme(
            const TextTheme(
                titleSmall: TextStyle(
                    color: Color(0xff949C9E),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
                titleMedium: TextStyle(
                    color: Color(0xff323238),
                    fontSize: 16,
                    fontWeight: FontWeight.normal)),
          ),
          iconTheme: IconThemeData(color: themeBlue),
          appBarTheme: AppBarTheme(
              titleTextStyle: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500, fontSize: 18)),
          dividerColor: const Color(0xffF2F2F2),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: themeBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  textStyle: GoogleFonts.roboto(
                      fontSize: 14.0, fontWeight: FontWeight.w500))),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
            foregroundColor: themeBlue,
            backgroundColor: const Color(0xffedf8ff),
            padding: const EdgeInsets.all(12.0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            textStyle:
                GoogleFonts.roboto(fontSize: 14.0, fontWeight: FontWeight.w500),
          )),
          inputDecorationTheme: InputDecorationTheme(
              fillColor: Colors.transparent,
              prefixIconColor: themeBlue,
              suffixIconColor: themeBlue,
              hintStyle: GoogleFonts.roboto(
                  fontSize: 16,
                  color: const Color(0xff949C9E),
                  fontWeight: FontWeight.normal),
              contentPadding: const EdgeInsets.all(0.0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide:
                    const BorderSide(width: 1.0, color: Color(0xffE5E5E5)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: const BorderSide(width: 1.0, color: Colors.red),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide:
                    const BorderSide(width: 1.0, color: Color(0xffE5E5E5)),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide:
                    const BorderSide(width: 1.0, color: Color(0xffE5E5E5)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide:
                    const BorderSide(width: 1.0, color: Color(0xffE5E5E5)),
              ))),
      home: const HomePage(),
    );
  }
}
