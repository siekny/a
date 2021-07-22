import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:htb_mobile/config/constant.dart';
import 'package:htb_mobile/config/routes/Routes.dart';
import 'package:htb_mobile/cubit/product_detail_cubit.dart';
import 'dart:convert';
import 'package:htb_mobile/cubit/search_cubit.dart';
import 'package:htb_mobile/cubit/wishlist_cubit.dart';
import 'package:htb_mobile/data/models/image_response.dart';
import 'package:htb_mobile/utils/themes/Theme.dart';
import 'package:camera/camera.dart';
import 'package:htb_mobile/views/screens/category/third_level_category_screen.dart';
import 'package:htb_mobile/views/screens/homeProduct/product_detail_screen.dart';
import 'package:htb_mobile/views/screens/qrscan/take_picture_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class SearchBar extends StatefulWidget {
  String search;
  SearchBar({Key key, String search}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  static var myController = TextEditingController();

  @override
  void dispose() {
    // myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Constant.currentSearch != null
        ? myController.text = Constant.currentSearch
        : myController.text = "";

    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ]),
        child: TextField(
          controller: myController,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 14),
            icon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                onTap: () {
                  // Navigator.of(context).pushNamed(Routes.qrScan);
                  print("taobao");
                  if (Constant.isTaobao) {
                    setState(() {
                      Constant.isTaobao = false;
                      Toast.show("Provider has set to Alibaba1668", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                    });
                  } else {
                    setState(() {
                      Toast.show("Provider has set to Taobao", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                      Constant.isTaobao = true;
                    });
                  }
                },
                child: SvgPicture.asset(
                  Constant.isTaobao == true
                      ? "assets/images/taobao.svg"
                      : "assets/images/alibaba.svg",
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            prefixIcon: Container(
              transform: Matrix4.translationValues(-15, 0, 0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.qrScan);
                },
                child: Icon(
                  MdiIcons.qrcodeScan,
                  size: 18,
                  color: HexColor.fromHex('#C9C9C9'),
                ),
              ),
            ),
            suffixIcon: InkWell(
              onTap: () {
                _showOptions(context);
              },
              child: Icon(
                MdiIcons.camera,
                size: 20,
                color: HexColor.fromHex('#C9C9C9'),
              ),
            ),
            hintText: 'What are you looking for...',
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          onSubmitted: _onSearchSet,
          style: TextStyle(
            fontSize: 14,
          ),
        ));
  }

  String _path = null;

  void _onSearchSet(String search) {
    if (search.isEmpty) {
      Toast.show("What are you looking for?", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    } else {
      print("search " + search);
      String finalId;
      Constant.currentSearch = search;

      if (isUrl(search)) {
        finalId = extractIdFromUrl(search);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<ProductDetailCubit>(
                        create: (context) =>
                            ProductDetailCubit()..getProductDetail(finalId),
                      ),
                      BlocProvider<WishListCubit>(
                        create: (context) => WishListCubit()..getWishLists(),
                      ),
                    ],
                    child: ProductDetailScreen(
                      productId: finalId,
                    ),
                  )),
        );
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlocProvider<SearchCubit>(
                  create: (context) => SearchCubit()
                    ..getProductByTitle(
                        myController.text, 1, 12, "Default order"),
                  child: ThirdLevelCategoryScreen(),
                )));
      }
    }
  }

  void _showPhotoLibrary() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _path = file.path;
      Constant.globalImageSearch = _path;
      _showDialog(context);
    });
  }

  void _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)));

    setState(() {
      _path = result;
      Constant.globalImageSearch = _path;
      _showDialog(context);
    });
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 150,
              child: Column(children: <Widget>[
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showCamera();
                    },
                    leading: Icon(Icons.photo_camera),
                    title: Text("Take a picture from camera")),
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showPhotoLibrary();
                    },
                    leading: Icon(Icons.photo_library),
                    title: Text("Choose from photo library"))
              ]));
        });
  }

  String extractIdFromUrl(String url) {
    String finalId;

    var g = url.split('&');

    print(g);
    for (int i = 0; i < g.length; i++) {
      if (g[i].startsWith('id=')) {
        finalId = g[i].split('=')[1];
        print(g[i].split('=')[1]);
      }
    }

    return finalId;
  }

  void _showDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height - 80,
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Column(children: <Widget>[
                _path == null
                    ? Image.asset("images/default_image.png")
                    : Image.file(File(_path)),
                FlatButton(
                  child:
                      Text("Take Again", style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                  onPressed: () {
                    _showOptions(context);
                  },
                ),
                FlatButton(
                  child: Text("OK", style: TextStyle(color: Colors.white)),
                  color: Colors.yellow,
                  onPressed: () async {
                    var request = http.MultipartRequest(
                        'POST',
                        Uri.parse(
                            'http://178.128.110.84/htb_demo/api_v1/upload/search/image'));
                    request.files
                        .add(await http.MultipartFile.fromPath('image', _path));

                    // var response = await request.send();
                    request
                        .send()
                        .then((result) async {
                          http.Response.fromStream(result).then((response) {
                            if (response.statusCode == 200) {
                              print("Uploaded! ");
                              print('response.body ' + response.body);
                              var converted = ImageReponse.fromJson(
                                  jsonDecode(response.body));

                              Constant.photo = converted.data.image;
                              Constant.isSearchbyPhoto = true;
                              print(Constant.isSearchbyPhoto);
                              String cat_id;
                              if (Constant.isTaobao)
                                cat_id = "Taobao";
                              else
                                cat_id = "Alibaba1688";
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      BlocProvider<SearchCubit>(
                                        create: (context) => SearchCubit()
                                          ..getSearchResultbyImage(
                                              converted.data.image, 0, 12),
                                        child: ThirdLevelCategoryScreen(),
                                      )));
                            }
                          });
                        })
                        .catchError((err) => print('error : ' + err.toString()))
                        .whenComplete(() {});
                  },
                )
              ]),
            ),
          );
        });
  }

  bool isUrl(String search) {
    if (search.contains("http"))
      return true;
    else
      return false;
  }
}
