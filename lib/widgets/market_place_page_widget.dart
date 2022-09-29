import 'package:cached_network_image/cached_network_image.dart';
//import '/config/app_strings.dart';
import '/models/experiences_model.dart';
import '../pages/market_place_more_info_page.dart';

import '/config/app_config.dart';
import 'package:flutter/material.dart';

import '/widgets/logo_profile_widget.dart';

class MarketPlacePageWidget extends StatefulWidget {
  final List<ExperiencesModel> experiencesList;

  const MarketPlacePageWidget(this.experiencesList, {Key? key})
      : super(key: key);

  @override
  _MarketPlacePageWidgetState createState() => _MarketPlacePageWidgetState();
}

class _MarketPlacePageWidgetState extends State<MarketPlacePageWidget> {
  @override
  Widget build(BuildContext context) {
    //final deviceWidth = MediaQuery.of(context).size.width;
    //final deviceHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        color: const Color(AppConfig.blackColor),
        //Colors.black,
        child: Column(
          children: [
            const LogoProfileWidget(),
            /* Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              alignment: Alignment.topLeft,
              child: const Text(
                AppStrings.marketPlace,
                // 'Experiences',
                //textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ), */
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.experiencesList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      // Image.asset(AppConfig.logoImage),
                      Container(
                        // width: deviceWidth * .92,
                        margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: widget.experiencesList[index].assetUrl,
                            //'${_hotelInfoProvData.hotelRoomTypeModel[index].roomTypeImages[indexVal]['links']['full']}${AppStrings.hotelInfoRenderHeight}',
                            placeholder: (context, url) => Image.asset(
                              AppConfig.defaultImage,
                              //width: 50,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              AppConfig.defaultImage,
                              // width: 50,
                            ),
                            fit: BoxFit.fill,
                          ),
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
                        margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.experiencesList[index].title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      // Change this
                      /* Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.experiencesList[index].description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ), */
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: ElevatedButton(
                              onPressed: () => Navigator.of(context).pushNamed(
                                  MarketPlaceMoreInfoPage.routeName,
                                  arguments: {
                                    "image":
                                        widget.experiencesList[index].assetUrl,
                                    "title":
                                        widget.experiencesList[index].title,
                                    "description": widget
                                        .experiencesList[index].description,
                                    "price":
                                        widget.experiencesList[index].price,
                                    "player_id":
                                        widget.experiencesList[index].playerId,
                                    "exp_id": widget.experiencesList[index].id,
                                  }),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                              ),
                              child: const Text(
                                'More Info',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                              alignment: Alignment.topLeft,
                              child: Text(
                                '£ ${widget.experiencesList[index].price}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              )),
                        ],
                      ),
                      // const Divider(),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
