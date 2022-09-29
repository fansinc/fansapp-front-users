import 'package:fansinc/pages/home_page.dart';

import '/providers/address_provider.dart';
import '/providers/wallet_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../config/app_strings.dart';
import '../config/app_config.dart';
//import '../pages/auth_page.dart';

class AddressWidget extends StatefulWidget {
  /*  static const routeName = '/registerPage'; */

  const AddressWidget({Key? key}) : super(key: key);

  @override
  _AddressWidgetState createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? addrLine1;
  String? addrLine2;
  String? city;
  String? state;
  String? postal;
  String? country;

  bool? checkVal = false;

/*   TextEditingController nameController;
  TextEditingController emailController; */
  TextEditingController passwordController = TextEditingController();
  //TextEditingController passwordConfirmController;

/*   FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode passwordConfirmFocusNode = FocusNode(); */

  void validateSubmit() async {
    // if (_formKey.currentState.validate()) {
    var valid = _formKey.currentState!.validate();
    setState(() {
      isLoading = true;
    });
    if (valid) {
      try {
        _formKey.currentState!.save();
        await Provider.of<AddressProvider>(context, listen: false)
            .createAddress(
                addrLine1!, addrLine2!, city!, state!, postal!, country!)
            .then((value) {
          Provider.of<WalletProvider>(context, listen: false)
              .createWalletInterest(true)
              .then((value) {
            setState(() {
              isLoading = false;
            });
            showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text(AppStrings.success),
                    content: const Text(AppStrings.walletSubmitSuccess),
                    actions: [
                      ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushReplacementNamed(HomePage.routeName);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                          ),
                          icon: const Icon(Icons.close),
                          label: const Text(AppStrings.close))
                    ],
                  );
                });
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
                          /*  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          AuthPage.routeName); */
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
                        /*  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          AuthPage.routeName); */
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
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AppStrings.addrLine1,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(AppConfig.grey),
                  border: Border.all(
                      // color: Colors.red,
                      ),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: TextFormField(
                //controller: nameController,
                style: const TextStyle(
                  color: Colors.black,
                  // Color(AppConfig.blueColor),
                ),
                cursorColor: Colors.black,
                //Color(AppConfig.blueColor),
                //controller: loginEmailController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.next,
                //focusNode: firstNameFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return (AppStrings.addrLine1Validate);
                  }
                  return null;
                },
                /* =>
                                value.isEmpty ? AppStrings.nameValidate : null, */
                onSaved: (value) {
                  addrLine1 = value!;
                },
                //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              AppStrings.addrLine2,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(AppConfig.grey),
                  border: Border.all(
                      // color: Colors.red,
                      ),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: TextFormField(
                //controller: nameController,
                style: const TextStyle(
                  color: Colors.black,
                  // Color(AppConfig.blueColor),
                ),
                cursorColor: Colors.black,
                //Color(AppConfig.blueColor),
                //controller: loginEmailController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.next,
                //focusNode: lastNameFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return (AppStrings.addrLine2Validate);
                  }
                  return null;
                },
                /* =>
                                value.isEmpty ? AppStrings.nameValidate : null, */
                onSaved: (value) {
                  addrLine2 = value!;
                },
                //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              AppStrings.city,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(AppConfig.grey),
                  border: Border.all(
                      // color: Colors.red,
                      ),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  // Color(AppConfig.blueColor),
                ),
                cursorColor: Colors.black,
                //Color(AppConfig.blueColor),
                //controller: loginEmailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    value!.isEmpty ? AppStrings.cityValidate : null,
                onChanged: (value) {
                  city = value;
                },
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              AppStrings.stateProvince,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(AppConfig.grey),
                  border: Border.all(
                      // color: Colors.red,
                      ),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: TextFormField(
                //controller: nameController,
                style: const TextStyle(
                  color: Colors.black,
                  // Color(AppConfig.blueColor),
                ),
                cursorColor: Colors.black,
                //Color(AppConfig.blueColor),
                //controller: loginEmailController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.next,
                //focusNode: mobileFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return (AppStrings.stateProvinceValidate);
                  }
                  return null;
                },
                /* =>
                                value.isEmpty ? AppStrings.nameValidate : null, */
                onSaved: (value) {
                  state = value!;
                },
                //onFieldSubmitted: (_) => emailFocusNode.nextFocus,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              AppStrings.postal,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(AppConfig.grey),
                  border: Border.all(
                      // color: Colors.red,
                      ),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  // Color(AppConfig.blueColor),
                ),
                cursorColor: Colors.black,
                //Color(AppConfig.blueColor),
                //controller: loginPasswordController,
                obscureText: false,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return (AppStrings.postalValidate);
                  }
                  /* if (value.isNotEmpty && value.length < 8) {
                    return (AppStrings.passwordLengthValidate);
                  } */
                  return null;
                },
                /* validator: (value) => value!.isEmpty
                              ? AppStrings.passwordValidate
                              : null, */
                onChanged: (value) {
                  postal = value;
                },
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              AppStrings.country,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(AppConfig.grey),
                  border: Border.all(
                      // color: Colors.red,
                      ),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  // Color(AppConfig.blueColor),
                ),
                cursorColor: Colors.black,
                //Color(AppConfig.blueColor),
                //controller: loginPasswordController,
                obscureText: false,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),

                validator: (value) {
                  if (value!.isEmpty) {
                    return (AppStrings.countryValidate);
                  }
                  /* if (value.isNotEmpty && value.length < 8) {
                    return (AppStrings.passwordLengthValidate);
                  } */
                  return null;
                },
                /* validator:
                           (value) => value!.isEmpty
                              ? AppStrings.passwordValidate
                              : null, */
                onChanged: (value) {
                  country = value;
                },
              ),
            ),
            /* Container(
                    child:  */

            //),
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      //Color(AppConfig.greenColor),
                    ),
                    onPressed: () => validateSubmit(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      child: const Text(
                        AppStrings.submit,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

            //),
            //const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
