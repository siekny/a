import 'package:flutter/material.dart';
import 'package:htb_mobile/utils/check_box_listtile_model.dart';
import 'package:htb_mobile/views/widgets/sub_screen_appbar.dart';

class ProductDetailConfigScreen extends StatefulWidget {
  @override
  _ProductDetailConfigScreenState createState() =>
      _ProductDetailConfigScreenState();
}

class _ProductDetailConfigScreenState extends State<ProductDetailConfigScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  double sizeBetween;

  List<CheckBoxListTileModel> checkBoxListTileModel = <CheckBoxListTileModel>[];

  Map<String, List<dynamic>> myProperties = {};

  int _choiceIndex;
  List<CompanyWidget> _companies;

  @override
  void initState() {
    super.initState();
    //
    // _choiceIndex= -1;
    // _companies = <CompanyWidget>[
    //   CompanyWidget('CEO'),
    //   CompanyWidget('Director'),
    //   CompanyWidget('Manager'),
    //   CompanyWidget('Manager'),
    //   CompanyWidget('Team Leader'),
    //   CompanyWidget('Employee'),
    // ];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    sizeBetween = height / 20;
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, List<dynamic>>;
    final properties = routeArgs["property"] as List<dynamic>;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: SubScreenAppBar.getAppBar('Options'),
      body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: properties.map((e) {
                    final values = e["Value"] as List<dynamic>;
                    int index = 0;
                    myProperties = {'${e["Id"]}': values};
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("${e["DisplayName"]}"),
                        Wrap(
                            children: values.map((property) {
                          // myProperties.update('${e["Id"]}', (value) => );
                          return (property["Picture"] == null)
                              ? ChoiceChip(
                                  label: Text("${property["DisplayName"]}"),
                                  selected: productPropertyStatus(
                                          e["Id"], property["Id"])
                                      ? true
                                      : false,
                                  selectedColor: Colors.red,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      setPropertyStatus(
                                          e["Id"], selected, property["Id"]);
                                    });
                                  },
                                  backgroundColor: Color(0xffEDEDED),
                                  labelStyle: TextStyle(color: Colors.black),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      setPropertyStatus(
                                          e["Id"], true, property["Id"]);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: productPropertyStatus(
                                                e["Id"], property["Id"])
                                            ? Border.all(
                                                color: Colors.amber, width: 4)
                                            : Border.all(
                                                color: Colors.white, width: 4)),
                                    margin: EdgeInsets.only(right: 10, top: 10),
                                    child: Image.network(
                                      property["Picture"]["Url"],
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                );
                        }).toList()),
                      ],
                    );
                  }).toList()))),
      bottomNavigationBar: Container(
        height: 56,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {
                  print(myProperties);
                },
                child: Container(
                  alignment: Alignment.center,
                  color: Color(0xffFDBA2D),
                  child: Text("Continue",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setStatus(bool val, String id) {
    resetStatus(false);
    setState(() {
      // checkBoxListTileModel.firstWhere((e)=>e.productId==id).isCheck=  val;
      checkBoxListTileModel.firstWhere((e) => e.productId == id).isCheck = val;
    });
  }

  void resetStatus(bool status) {
    for (int i = 0; i < checkBoxListTileModel.length; i++) {
      setState(() {
        checkBoxListTileModel[i].isCheck = status;
      });
    }
  }

  bool productStatus(String id) {
    return checkBoxListTileModel.firstWhere((e) => e.productId == id).isCheck;
  }

  //

  void setPropertyStatus(String key, bool val, String id) {
    resetPropertyStatus(key, false);
    setState(() {
      myProperties[key].firstWhere((e) => e.productId == id).isCheck = val;
    });
  }

  void resetPropertyStatus(String key, bool status) {
    for (int i = 0; i < myProperties[key].length; i++) {
      setState(() {
        myProperties[key][i].isCheck = status;
      });
    }
  }

  bool productPropertyStatus(String key, String id) {
    return myProperties[key].firstWhere((e) => e.productId == id).isCheck;
  }

  Iterable<Widget> get companyPosition sync* {
    for (int i = 0; i < _companies.length; i++) {
      yield Padding(
        padding: const EdgeInsets.all(6.0),
        child: ChoiceChip(
          label: Text(_companies[i].name),
          selected: _choiceIndex == i,
          selectedColor: Colors.red,
          onSelected: (bool selected) {
            setState(() {
              _choiceIndex = selected ? i : -1;
            });
          },
          backgroundColor: Colors.grey,
          labelStyle: TextStyle(color: Colors.black),
        ),
      );
    }
  }

  // Widget _buildChoiceChips() {
  //   return Container(
  //     height: MediaQuery.of(context).size.height/4,
  //     child: ListView.builder(
  //       itemCount: _choices.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         return ChoiceChip(
  //           label: Text(_choices[index]),
  //           selected: _choiceIndex == index,
  //           selectedColor: Colors.red,
  //           onSelected: (bool selected) {
  //             setState(() {
  //               _choiceIndex = selected ? index : -1;
  //             });
  //           },
  //           backgroundColor: Colors.green,
  //           labelStyle: TextStyle(color: Colors.white),
  //         );
  //       },
  //     ),
  //   );
  // }
}

class CompanyWidget {
  const CompanyWidget(this.name);
  final String name;
}
