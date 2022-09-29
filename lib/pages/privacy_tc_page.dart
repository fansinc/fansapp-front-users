import 'dart:convert';
import '/config/app_config.dart';
import '/config/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyTermsPage extends StatefulWidget {
  static const routeName = '/privacyTermsPage';

  const PrivacyTermsPage({Key? key}) : super(key: key);
  //final AppDetail appDetail;

/*   PrivacyAboutTermsPage({
    Key key,
    //  @required this.appDetail,
  }) : super(key: key);
 */
  @override
  _PrivacyTermsPageState createState() => _PrivacyTermsPageState();
}

class _PrivacyTermsPageState extends State<PrivacyTermsPage> {
  WebViewController? _controller;
  bool isInitialized = false;
  //AppDetail appDetail = AppDetail.privacy;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.privacyTermsPolicy,
            // appStrings[pageTitle],
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SafeArea(
            child: WebView(
          initialUrl: AppConfig.privacyTermsUrl,
          //webUrl, //getURL(appDetail),
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
        )
            //.paddingVerticalHorizontal(15.0, 10.0),
            ),
      ),
    );
  }

  void loadHtml(String htmlData) async {
    _controller!.loadUrl(
      Uri.dataFromString(
        htmlData,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ).toString(),
    );
  }
}
