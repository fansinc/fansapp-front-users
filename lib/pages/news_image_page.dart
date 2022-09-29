import 'package:photo_view/photo_view.dart';

import 'package:flutter/material.dart';

class NewsImagePage extends StatelessWidget {
  static const routeName = '/newsImagePage';

  const NewsImagePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final url = args['url'];
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            //automaticallyImplyLeading: true,
            /*  centerTitle: true,
          title: const Text(
            AppStrings.profilePage,
            style: TextStyle(color: Colors.white),
          ), */
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            iconTheme: const IconThemeData(
              //color: Color(AppColors.blueColor),
              color: Colors.white, //change your color here
            ),
          ),
          backgroundColor: Colors.black,
          body: PhotoView(imageProvider: NetworkImage(url)
              //AssetImage("assets/large-image.jpg"),
              )
          /* CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => Image.asset(
            AppConfig.defaultImage,
            //width: 50,
          ),
          errorWidget: (context, url, error) => Image.asset(
            AppConfig.defaultImage,
            // width: 50,
          ),
          fit: BoxFit.fill,
        ), */
          ),
    );
  }
}
