import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/cubit/search_cubit.dart';
import 'package:htb_mobile/views/screens/category/third_level_category_screen.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrCodeResult;

  bool backCamera = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Scan using:" + (backCamera ? "Front Cam" : "Back Cam")),
          actions: <Widget>[
            IconButton(
              icon: backCamera
                  ? Icon(Icons.photo_camera_back)
                  : Icon(Icons.camera),
              onPressed: () {
                setState(() {
                  backCamera = !backCamera;
                  camera = backCamera ? 1 : -1;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.qr_code_scanner),
              onPressed: () async {
                ScanResult codeSanner = await BarcodeScanner.scan(
                  options: ScanOptions(
                    useCamera: camera,
                  ),
                ); //barcode scnner
                setState(() {
                  qrCodeResult = codeSanner.rawContent;
                });
              },
            )
          ],
        ),
        body: Center(
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider<SearchCubit>(
                              create: (context) => SearchCubit()
                                ..getRatingCategories(
                                    "otc-866", 1, 12, "Default order"),
                              child: ThirdLevelCategoryScreen(),
                            )),
                  );
                },
                child: Text(
                    (qrCodeResult == null) || (qrCodeResult == "")
                        ? "Please Scan to see your order"
                        : "Click here" + qrCodeResult,
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.w700)))));
  }
}

int camera = 1;
