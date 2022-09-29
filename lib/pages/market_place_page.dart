import '/config/app_config.dart';
import '/config/app_strings.dart';
import '/models/experiences_model.dart';
import '/providers/experiences_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/market_place_page_widget.dart';
import '/widgets/bottom_navbar_widget.dart';
import 'email_auth_page.dart';

class MarketPlacePage extends StatefulWidget {
  static const routeName = '/marketPlacePage';

  const MarketPlacePage({Key? key}) : super(key: key);

  @override
  _MarketPlacePageState createState() => _MarketPlacePageState();
}

class _MarketPlacePageState extends State<MarketPlacePage> {
  bool isInit = true;
  bool isLoading = false;

  List<ExperiencesModel> experiencesList = [];

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<ExperiencesProvider>(context)
          .fetchSetExperiences()
          .then((value) {
        experiencesList = value;
        setState(() {
          isLoading = false;
        });
      }).catchError((error) {
        final errorMsgStr = error.toString();
        String errorMsg, errorTitle;
        if (errorMsgStr.contains('Unauthenticated')) {
          errorMsg = AppStrings.unAuthError;
          errorTitle = AppStrings.alert;
        } else {
          errorMsg = errorMsgStr;
          errorTitle = AppStrings.error;
        }
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(errorTitle),
                //const Text(AppStrings.error),
                content: Text(errorMsg),
                //Text(error.toString())
                actions: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pop(); // Navigate to previous screen
                        if (error.toString() == AppStrings.tokenExpiryMessage) {
                          Navigator.of(context)
                              .pushReplacementNamed(EmailAuthPage.routeName);
                        }
                      },
                      icon: const Icon(Icons.close),
                      label: const Text(AppStrings.close))
                ],
              );
            });
        setState(() {
          isLoading = false;
        });
      });
    }
    super.didChangeDependencies();
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: true,
        child: Scaffold(
          //appBar: AppBar(),
          body: isLoading
              ? Container(
                  color: const Color(AppConfig.blackColor),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : MarketPlacePageWidget(experiencesList),
          backgroundColor: const Color(AppConfig.blackColor),
          //ExperiencesPageWidget(),
          bottomNavigationBar: const BottomNavBarWidget(3),
        ));
  }
}
