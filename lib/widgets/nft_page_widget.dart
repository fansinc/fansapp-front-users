import '/config/app_strings.dart';
import '/pages/email_auth_page.dart';
import '/providers/wallet_provider.dart';
import 'package:provider/provider.dart';

import '/config/app_config.dart';
import '/widgets/logo_profile_widget.dart';

import 'package:flutter/material.dart';

import 'address_widget.dart';

class NFTPageWidget extends StatefulWidget {
  const NFTPageWidget({Key? key}) : super(key: key);

  @override
  _NFTPageWidgetState createState() => _NFTPageWidgetState();
}

class _NFTPageWidgetState extends State<NFTPageWidget> {
  bool isInit = true;
  bool isLoading = false;
  bool walletStatus = false;
  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<WalletProvider>(context).getWalletInterest().then((value) {
        walletStatus = value.walletInterestStatus;
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
                        primary: Colors.black,
                        //Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        /*   Navigator.of(context)
                            .pop(); // Navigate to previous screen */
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
    //final deviceWidth = MediaQuery.of(context).size.width;
    //final deviceHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          const LogoProfileWidget(),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            alignment: Alignment.center,
            child: Image.asset(
              AppConfig.nftImageGIF,
              //height: 200,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: const Text(
              'Showcasing the exclusive launch of Rocavaka Rugby NFT and the AW1 bottle',
              //'Rocavaka Rugby AW1 edition, coming soon ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : walletStatus
                  ? Container(
                      margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: const Text(
                        'Thanks for registering, access to your wallet will be sent by email',
                        //'Thanks for registering, we will keep you posted',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  : Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: const Text(
                            'For your NFT Wallet* fill in details below',
                            //'Register your interest for 1 of the limited editions',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        const AddressWidget(),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(30, 5, 20, 5),
                          child: const Text(
                            '* Access to your wallet will be sent by email',
                            //'Thanks for registering, we will keep you posted',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
        ],
      ),
    );
  }
}
