// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '/config/app_strings.dart';
import '/providers/purchase_provider.dart';
import 'package:provider/provider.dart';

import '/config/app_config.dart';
import 'package:flutter/material.dart';

//import '/widgets/logo_profile_widget.dart';

class MarketPlaceMoreInfoPageWidget extends StatefulWidget {
  final image, title, desc, price, playerId, expId;

  const MarketPlaceMoreInfoPageWidget(
      this.image, this.title, this.desc, this.price, this.playerId, this.expId,
      {Key? key})
      : super(key: key);

  @override
  _MarketPlaceMoreInfoPageWidgetState createState() =>
      _MarketPlaceMoreInfoPageWidgetState();
}

class _MarketPlaceMoreInfoPageWidgetState
    extends State<MarketPlaceMoreInfoPageWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var cardNo, expiryMonth, expiryYear, cvv;

  void purchasExp(playerId, expId, price, userId, statusId) {
    var valid = _formKey.currentState!.validate();
    if (valid) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        Provider.of<PurchaseProvider>(
          context,
          listen: false,
        )
            .purchaseExperience(
          playerId,
          expId,
          price,
          // double.parse(price).toInt(), //change this
          //userId,
          //statusId,
          cardNo,
          expiryMonth,
          expiryYear, cvv,
        )
            .then((_) {
          setState(() {
            isLoading = false;
          });
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text(AppStrings.success),
                  content: const Text(AppStrings.paymentSuccess),
                  actions: [
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pop(); // Navigating back to experience page
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        icon: const Icon(Icons.close),
                        label: const Text(AppStrings.close))
                  ],
                );
              });
        }).catchError((error) {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text(AppStrings.error),
                  content: Text(error.toString()),
                  actions: [
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
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
      } catch (error) {
        //print(error);
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text(AppStrings.error),
                content: Text(error.toString()),
                actions: [
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                      label: const Text(AppStrings.close))
                ],
              );
            });
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    //final deviceHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        color: const Color(AppConfig.blackColor),
        //Colors.black,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          child: Column(
            children: [
              // LogoProfileWidget(),
              /*   Container(
                child:  */
              Column(
                children: [
                  // Image.asset(AppConfig.logoImage),
                  Container(
                    // width: deviceWidth * .92,
                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: widget.image,
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
                    ),
                  ),
                  /*  SizedBox(
                            height: 10,
                          ), */
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.desc,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '£ ${widget.price}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )),

                  // Credit card details
                  Column(children: [
                    Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: const Text(
                          AppStrings.creditCard,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )),
                    Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: const Text(
                          AppStrings.creditCardDisclaimer,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        )),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          // width: 2,
                        ),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          //padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: const Text(
                                    AppStrings.creditCardNo,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  )),
                              Container(
                                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: TextFormField(
                                  //controller: emailController,
                                  //focusNode: cardFocusNode,
                                  style: const TextStyle(color: Colors.white),
                                  maxLength: 16,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.white,
                                  decoration: const InputDecoration(
                                    //  labelText: AppStrings.creditCardNo,
                                    fillColor: Colors.white,
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    //icon: Icon(Icons.credit_card),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return (AppStrings.creditCardValidate);
                                    }
                                    if (value.isNotEmpty && value.length < 15 ||
                                        value.length > 16) {
                                      return (AppStrings
                                          .creditCardLengthValidate);
                                    } else {
                                      return null;
                                    }
                                  },
                                  /*  =>
                                          value.isEmpty ? AppStrings.emailValidate : null, */
                                  onSaved: (value) {
                                    cardNo = value;
                                  },
                                  //onFieldSubmitted: (_) => passwordFocusNode.nextFocus,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 100,
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Month (MM)',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          TextFormField(
                                            cursorColor: Colors.white,
                                            textAlign: TextAlign.center,
                                            //controller: emailController,
                                            //focusNode: cardFocusNode,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            maxLength: 2,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              //  labelText: AppStrings.creditCardNo,
                                              fillColor: Colors.white,
                                              labelStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                              //icon: Icon(Icons.credit_card),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            textInputAction:
                                                TextInputAction.done,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return (AppStrings
                                                    .creditCardRequiredValidate);
                                              }
                                              if (value.isNotEmpty &&
                                                  value.length != 2) {
                                                return (AppStrings
                                                    .creditCardMonthLengthValidate);
                                              }
                                              if (value.isNotEmpty &&
                                                      /* int.parse(value) <
                                                          int.parse(DateFormat('M')
                                                              .format(
                                                                  DateTime.now())) && */
                                                      int.parse(value) < 1 ||
                                                  int.parse(value) > 12) {
                                                return (AppStrings
                                                    .creditCardMonthPeriodValidate);
                                              } else {
                                                return null;
                                              }
                                            },
                                            /*  =>
                                                    value.isEmpty ? AppStrings.emailValidate : null, */
                                            onSaved: (value) {
                                              expiryMonth = int.parse(value!);
                                            },
                                            //onFieldSubmitted: (_) => passwordFocusNode.nextFocus,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Year (YYYY)',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          TextFormField(
                                            //controller: emailController,
                                            //focusNode: cardFocusNode,
                                            textAlign: TextAlign.center,
                                            cursorColor: Colors.white,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            maxLength: 4,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              //  labelText: AppStrings.creditCardNo,
                                              fillColor: Colors.white,
                                              labelStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                              //icon: Icon(Icons.credit_card),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            textInputAction:
                                                TextInputAction.done,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return (AppStrings
                                                    .creditCardRequiredValidate);
                                              }
                                              if (value.isNotEmpty &&
                                                  value.length != 4) {
                                                return (AppStrings
                                                    .creditCardYearLengthValidate);
                                              }
                                              if (value.isNotEmpty &&
                                                  int.parse(value) <
                                                      int.parse(DateFormat('y')
                                                          .format(DateTime
                                                              .now()))) {
                                                return (AppStrings
                                                    .creditCardYearPeriodValidate);
                                              } else {
                                                return null;
                                              }
                                            },
                                            /*  =>
                                                value.isEmpty ? AppStrings.emailValidate : null, */
                                            onSaved: (value) {
                                              expiryYear = int.parse(value!);
                                            },
                                            //onFieldSubmitted: (_) => passwordFocusNode.nextFocus,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 100,
                                      child: Column(
                                        children: [
                                          const Text(
                                            'CVV',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          TextFormField(
                                            style: const TextStyle(
                                                color: Colors.white),
                                            cursorColor: Colors.white,
                                            textAlign: TextAlign.center,
                                            //controller: emailController,
                                            //focusNode: cardFocusNode,
                                            maxLength: 4,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              //  labelText: AppStrings.creditCardNo,
                                              fillColor: Colors.white,
                                              labelStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                              //icon: Icon(Icons.credit_card),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            textInputAction:
                                                TextInputAction.done,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return (AppStrings
                                                    .creditCardRequiredValidate);
                                              }
                                              if (value.isNotEmpty &&
                                                      value.length < 3 ||
                                                  value.length > 4) {
                                                return (AppStrings
                                                    .creditCardCVVLengthValidate);
                                              } else {
                                                return null;
                                              }
                                            },
                                            /*  =>
                                                value.isEmpty ? AppStrings.emailValidate : null, */
                                            onSaved: (value) {
                                              cvv = int.parse(value!);
                                            },
                                            //onFieldSubmitted: (_) => passwordFocusNode.nextFocus,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                  /*  Container(
                      width: double.infinity,
                      height: 200,
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '£ ${widget.price}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )), */
                  SizedBox(
                    height: 50,
                    width: deviceWidth * .90,
                    child: ElevatedButton(
                      onPressed: () => purchasExp(
                          widget.playerId, widget.expId, widget.price, 3, 1),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                      ),
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            )
                          : const Text(
                              'Buy Now',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  )
                ],
              ),
              //),
            ],
          ),
        ),
      ),
    );
  }
}
