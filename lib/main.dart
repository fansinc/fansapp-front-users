/*
Fansinc Mobile App, United Kingdom
Copyright (c) 2022, Fansinc

Developed by Santhosh, Yunesg Ind Tech
https://www.hridhamtech.com
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//Providers

import 'pages/my_week_image_page.dart';
import 'pages/news_image_page.dart';
import 'providers/auth_provider.dart';
import 'providers/experiences_provider.dart';
import 'providers/my_week_provider.dart';
import 'providers/register_provider.dart';
import 'providers/news_provider.dart';
import 'providers/purchase_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/address_provider.dart';
import 'providers/wallet_provider.dart';
//Pages

import 'pages/splash_page.dart';
import 'pages/home_page.dart';
import 'pages/market_place_page.dart';
import 'pages/market_place_more_info_page.dart';
import 'pages/my_week_page.dart';
import 'pages/wallet_page.dart';
import 'pages/nft_page.dart';
//import 'pages/auth_page.dart';
import 'pages/email_auth_page.dart';
import 'pages/register_page.dart';
import 'pages/forgot_password_page.dart';
import 'pages/profile_page.dart';
import 'pages/privacy_tc_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set Orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /* // Set Safe Area Color
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    // Colors.white, // Only honored in Android M and above
      statusBarIconBrightness:
        Brightness.dark, // Only honored in Android M and above
    statusBarBrightness: Brightness.light, 
  ));*/

  runApp(const FansInc());
}

class FansInc extends StatefulWidget {
  const FansInc({Key? key}) : super(key: key);

  @override
  _FansIncState createState() => _FansIncState();
}

class _FansIncState extends State<FansInc> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => AuthProvider()),
          ChangeNotifierProvider(create: (ctx) => RegisterProvider()),
          ChangeNotifierProvider(create: (ctx) => NewsProvider()),
          ChangeNotifierProvider(create: (ctx) => ExperiencesProvider()),
          ChangeNotifierProvider(create: (ctx) => MyWeekProvider()),
          ChangeNotifierProvider(create: (ctx) => PurchaseProvider()),
          ChangeNotifierProvider(create: (ctx) => ProfileProvider()),
          ChangeNotifierProvider(create: (ctx) => AddressProvider()),
          ChangeNotifierProvider(create: (ctx) => WalletProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
          routes: {
            //AuthPage.routeName: (ctx) => const AuthPage(),
            EmailAuthPage.routeName: (ctx) => const EmailAuthPage(),
            RegisterPage.routeName: (ctx) => const RegisterPage(),
            ForgotPasswordPage.routeName: (ctx) => const ForgotPasswordPage(),
            HomePage.routeName: (ctx) => const HomePage(),
            NFTPage.routeName: (ctx) => const NFTPage(),
            MyWeekPage.routeName: (ctx) => const MyWeekPage(),
            MarketPlacePage.routeName: (ctx) => const MarketPlacePage(),
            MarketPlaceMoreInfoPage.routeName: (ctx) =>
                const MarketPlaceMoreInfoPage(),
            WalletPage.routeName: (ctx) => const WalletPage(),
            ProfilePage.routeName: (ctx) => const ProfilePage(),
            PrivacyTermsPage.routeName: (ctx) => const PrivacyTermsPage(),
            NewsImagePage.routeName: (ctx) => const NewsImagePage(),
            MyWeekImagePage.routeName: (ctx) => const MyWeekImagePage(),
            /*  ProfileEditPage.routeName: (ctx) => ProfileEditPage(), */
          },
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              // Set backwardsCompatibility to false
              // to tell the system that we are going to use systemOverlayStyle not brightness
              //backwardsCompatibility: false,

              // Use systemOverlayStyle to control status bar text color.
              systemOverlayStyle: SystemUiOverlayStyle.light,
              // SystemUiOverlayStyle.dark means System overlays text should be drawn with a dark color.
              // Intended for applications with a light background.

              // SystemUiOverlayStyle.light means System overlays text should be drawn with a light color.
              // Intended for applications with a dark background.
            ),
            fontFamily: 'NunitoSans',
            primaryTextTheme: const TextTheme(
              headline1: TextStyle(fontSize: 14),
            ),
          ),
        ));
  }
}
