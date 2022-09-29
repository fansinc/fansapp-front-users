import 'package:cached_network_image/cached_network_image.dart';
import '/pages/news_image_page.dart';
import '/widgets/video_player_widget.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '/models/news_model.dart';

import '/config/app_config.dart';

import '/widgets/logo_profile_widget.dart';
import 'package:flutter/material.dart';
//import '/config/app_strings.dart';
//import 'youtube_player_widget.dart';

class HomePageWidget extends StatefulWidget {
  final List<NewsModel> newsList;
  const HomePageWidget(this.newsList, {Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    //final deviceWidth = MediaQuery.of(context).size.width;
    //final deviceHeight = MediaQuery.of(context).size.height;
    /*   const urlSPSA = 'https://youtu.be/ZJe8zadgih4';
    const urlNextStep = 'https://youtu.be/pSLy14jLRRg';
    const urlNSF = 'https://youtu.be/SJKsUajU-vM'; */

    return SingleChildScrollView(
      child: Container(
        color: const Color(AppConfig.blackColor),
        //Colors.black,
        child: Column(
          children: [
            const LogoProfileWidget(),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              alignment: Alignment.topLeft,
              child: const Text(
                'Latest News',
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            /* Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 10, 10),
              child: YoutubePlayerWidget(
                autoPlay: false,
                videoId: YoutubePlayer.convertUrlToId(urlSPSA),
                //model.getVideoUrl(),
                fullScreenPressed: () {
                  //print('Toggle FullScreen');
                  // playerRotation.toggleFullscreen();
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 10, 5),
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      AppStrings.sbsa,
                      //textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    AppConfig.sbsaModified,
                    height: 50,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            /*  Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 10, 5),
              alignment: Alignment.topLeft,
              child: const Text(
                'Alex explains why he chose ‘Next Step’ charity for his testimonial year',
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ), */
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 10, 10),
              child: YoutubePlayerWidget(
                autoPlay: false,
                videoId: YoutubePlayer.convertUrlToId(urlNextStep),
                //model.getVideoUrl(),
                fullScreenPressed: () {
                  //print('Toggle FullScreen');
                  // playerRotation.toggleFullscreen();
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 10, 5),
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      AppStrings.nextStep,
                      //textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    AppConfig.nextStepModified,
                    height: 50,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            /*  Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 10, 5),
              alignment: Alignment.topLeft,
              child: const Text(
                'Alex explains why he chose Northampton Saints Foundation charity for his testimonial year',
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ), */
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 10, 10),
              child: YoutubePlayerWidget(
                autoPlay: false,
                videoId: YoutubePlayer.convertUrlToId(urlNSF),
                //model.getVideoUrl(),
                fullScreenPressed: () {
                  //print('Toggle FullScreen');
                  // playerRotation.toggleFullscreen();
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 10, 5),
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      AppStrings.northampton,
                      //textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    AppConfig.northamptonModified,
                    height: 50,
                  ),
                ],
              ),
            ), */
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.newsList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      // Image.asset(AppConfig.logoImage),
                      Container(
                        // width: deviceWidth * .92,
                        margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: widget.newsList[index].assetType == 'image'
                              ? GestureDetector(
                                  onTap: () => Navigator.of(context).pushNamed(
                                      NewsImagePage.routeName,
                                      arguments: {
                                        'url': widget.newsList[index].assetUrl,
                                      }),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.newsList[index].assetUrl,
                                    //'${_hotelInfoProvData.hotelRoomTypeModel[index].roomTypeImages[indexVal]['links']['full']}${AppStrings.hotelInfoRenderHeight}',
                                    placeholder: (context, url) => Image.asset(
                                      AppConfig.defaultImage,
                                      //width: 50,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      AppConfig.defaultImage,
                                      // width: 50,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : VideoPlayerWidget(
                                  widget.newsList[index].assetUrl),
                          //Container(),
                          /* FadeInImage(
                                          placeholder: AssetImage(
                                              AppConfig.defaultImage),
                                          image: NetworkImage(
                                            '${_hotelInfoProvData.hotelRoomTypeModel[index].roomTypeImages[indexVal]['links']['full']}${AppStrings.hotelInfoRenderHeight}',
                                          ),
                                          fit: BoxFit.fill,
                                        ), */
                        ),
                      ),
                      /*  SizedBox(
                        height: 10,
                      ), */
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.newsList[index].title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.newsList[index].description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      /* Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: deviceWidth * .40,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey,
                                  ),
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite,
                                  ),
                                  label: const Text(
                                    'Like',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: deviceWidth * .40,
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey,
                                  ),
                                  icon: const Icon(Icons.message),
                                  label: const Text(
                                    'Comment',
                                  ),
                                ),
                              )
                            ],
                          )), */
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
