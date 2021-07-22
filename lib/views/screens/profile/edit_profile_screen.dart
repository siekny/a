import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/config/routes/Routes.dart';
import 'package:htb_mobile/cubit/user_cubit.dart';
import 'package:htb_mobile/data/models/address.dart';
import 'package:htb_mobile/data/models/user.dart';
import 'package:htb_mobile/login.dart';
import 'package:htb_mobile/main.dart';
import 'package:htb_mobile/services/user_service.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:htb_mobile/views/widgets/ButtonField.dart';
import 'package:htb_mobile/views/widgets/InputField.dart';
import 'package:htb_mobile/views/widgets/sub_screen_appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  double sizeBetween;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    sizeBetween = height / 20;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: SubScreenAppBar.getAppBar('Profile'),
        body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          if (state is UserSuccess) {
            // print('user after ${state.user.address} ${state.user.fullName} ');
            return state.user == null
                ? Center(
                    child: ButtonField(
                        width: _width - 50,
                        title: 'Sign in',
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext ctx) => Login()));
                        })
                    // Text(
                    //     'You have not logged it yet. Please go to login first.'),
                    )
                : _userProfileView(state.user);
          } else if (state is UserFailure) {
            return Center(child: Text(state.exception.toString()));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }

  Widget _userProfileView(User user) {
    return RefreshIndicator(
        child: SingleChildScrollView(
            padding: EdgeInsets.all(AppSizes.sidePadding),
            child: Stack(children: [
              Container(
                // height: height * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormChangeProfile(
                      user: user,
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    // deliver address
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text(
                        'Delivery Address',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Card(
                        elevation: 4,
                        shadowColor: Colors.black26,
                        child: ListTile(
                            title: Text(
                              '${user?.address}',
                              style: TextStyle(fontSize: 13),
                            ),
                            subtitle: Text(
                              '${user?.phone}',
                              style: TextStyle(fontSize: 13),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                _gotoUpdateAddress(user);
                              },
                              child: Icon(MdiIcons.pencilOutline),
                            ))),

                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text(
                        'Help',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'FAQ',
                            style: TextStyle(
                                fontSize: 13, color: AppColors.darkGray),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.amber,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Shipping Address',
                            style: TextStyle(
                                fontSize: 13, color: AppColors.darkGray),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.amber,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 00, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Payment Method',
                            style: TextStyle(
                                fontSize: 13, color: AppColors.darkGray),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.amber,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ])),
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 1000));
          Provider.of<UserCubit>(context, listen: false).getUser();
        });
  }

  void _gotoUpdateAddress(user) async {
    await Navigator.of(context)
        .pushNamed(Routes.newAddress,
            arguments: Address(user?.address, user?.phone))
        .then((dynamic value) {
      if (value != null) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
              content: Text('Address has been updated successfully ...')));
      }
    });
  }
}

class FormChangeProfile extends StatefulWidget {
  @override
  _FormChangeProfileState createState() => _FormChangeProfileState();

  final User user;
  FormChangeProfile({this.user});
}

class _FormChangeProfileState extends State<FormChangeProfile> {
  File _image;
  final picker = ImagePicker();
  String stImage;
  String deliveryAddress;
  String deliveryPhone;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  String previousImage;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user?.username;
    emailController.text = widget.user?.email;
    phoneController.text = widget.user?.phone;
    fullNameController.text = widget.user?.fullName;
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    // double sizeBetween = height / 3;
    return Column(
      children: [
        Row(children: [
          // profile avatar
          CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              child: Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 12.0,
                    child: InkWell(
                      child: Icon(
                        Icons.camera_alt,
                        size: 15.0,
                        color: Color(0xFF404040),
                      ),
                      onTap: () {
                        _getImageGallery();
                      },
                    )),
              ),
              radius: 38.0,
              backgroundImage: stImage == null
                  ? (_image == null
                      ? previousImage == null
                          ? AssetImage(
                              'assets/images/profile/user-profile.png',
                            )
                          : NetworkImage('$previousImage')
                      : FileImage(_image))
                  : NetworkImage('$stImage'),
            ),
          ),

          Container(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              width: 200,
              child: TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  hintText: 'Full Name',
                ),
              )),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          //   child: IconButton(
          //     icon: Icon(MdiIcons.contentSaveOutline),
          //     onPressed: () {
          //       print('edit');
          //     },
          //     iconSize: 18,
          //   ),
          // ),
        ]),

        SizedBox(
          height: 30,
        ),

        // Name
        InputField(
          controller: nameController,
          hint: 'Name',
          keyboard: TextInputType.name,
        ),
        // Email
        InputField(
          controller: emailController,
          hint: 'Email',
          keyboard: TextInputType.emailAddress,
        ),

        // Phone Number
        InputField(
          controller: phoneController,
          hint: 'Phone Number',
          keyboard: TextInputType.phone,
        ),

        ButtonField(title: 'Save Change', onPressed: _validateAndSend),
      ],
    );
  }

  void _validateAndSend() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty) {
    } else {
      print(
          'hello $fullNameController , ${nameController.text}, ${emailController.text}, ${phoneController.text}');
      var jsonUser;
      if (_image != null) {
        UserService().postImage(_image).then((String result) {
          setState(
            () {
              stImage = result;
            },
          );
          print('image ... $stImage');
        }).onError((error, stackTrace) {
          print('post profile error : $error');
        });

        jsonUser = jsonEncode(<String, String>{
          'full_name': '${fullNameController.text}',
          'username': '${nameController.text}',
          'email': '${emailController.text}',
          'phone': '${phoneController.text}',
          'image': '$stImage',
        });
      } else {
        jsonUser = jsonEncode(<String, String>{
          'full_name': '${fullNameController.text}',
          'username': '${nameController.text}',
          'email': '${emailController.text}',
          'phone': '${phoneController.text}'
        });
      }

      BlocProvider.of<UserCubit>(context).updateUser(jsonUser);
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  _getImageGallery() async {
    PickedFile image = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      print('${image.path}');
    }
  }
}
