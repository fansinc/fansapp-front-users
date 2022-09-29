import 'package:flutter/material.dart';

import '../widgets/nft_page_widget.dart';
import '/widgets/bottom_navbar_widget.dart';

class NFTPage extends StatefulWidget {
  static const routeName = '/nftPage';

  const NFTPage({Key? key}) : super(key: key);

  @override
  _NFTPageState createState() => _NFTPageState();
}

class _NFTPageState extends State<NFTPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        bottom: true,
        child: Scaffold(
          //appBar: AppBar(),
          body: NFTPageWidget(),
          backgroundColor: Colors.black,
          bottomNavigationBar: BottomNavBarWidget(2),
        ));
  }
}
