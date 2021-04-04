import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

import 'getjsonclass.dart';
import 'utils.dart';
import 'stringhighlight.dart';

class Search_With_Load_data_From_Server extends StatefulWidget {
  List<Categories> categoriesList;

  Search_With_Load_data_From_Server({Key key, @required this.categoriesList})
      : super(key: key);

  @override
  _DeleteWidgetState createState() => _DeleteWidgetState();
}

class _DeleteWidgetState extends State<Search_With_Load_data_From_Server> {
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: widget.categoriesList != null
            ? parentView(widget.categoriesList, context)
            : Center(child: CircularProgressIndicator()));
  }

  Widget SearchWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          TextFormField(
            onChanged: (value) {
              setState(() {
              });
            },
            controller: editingController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                filled: true,
                fillColor: HexColor('#e4f6f6'),
                // labelText: "Search",
                hintText: "try searching fat,sauces names....",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)))),
          ),
        ],
      ),
    );
  }

  Widget headerView(
      BuildContext context, List<Categories> categories, int index) {
    return ListTile(
      leading: Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.pink), color: Colors.pink),
          child: Image.asset(
            'assets/images/twitterlogo.jpg',
            width: 25,
            height: 25,
          )),
      title: new Row(
        children: <Widget>[
          Text(
            categories[index].category.categoryName,
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: HexColor(categories[index].category.colorCode),
                fontSize: 15),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
          Text(
            categories[index].category.servingSize != null
                ? '  (' + '${categories[index].category.servingSize}' + ')'
                : '',
            style: new TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ],
      ),
    );
  }

  Widget parentView(List<Categories> dataList, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/cross.png',
                      width: 40,
                      height: 50,
                    ),
                    Image.asset(
                      'assets/images/twitterlogo.jpg',
                      width: 40,
                      height: 50,
                    ),
                  ],
                ),
                Text(
                  'Approved Foods List',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SearchWidget(),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (_, index1) {
                    if (index1 == 4)
                      return setconstantviewincategory();
                    else
                      return Card(
                        child: ExpansionTile(
                          key: Key(index1.toString()),
                          //attention
                          initiallyExpanded: index1 == 0,
                          title: headerView(context, dataList, index1),
                          children: [
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: dataList[index1]
                                  .category
                                  .subcategories
                                  .length,
                              itemBuilder: (_, index) {
                                return new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (editingController.text.isEmpty)
                                      Padding(
                                          child: Text(
                                            '${dataList[index1].category.subcategories[index].subCategoryname}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: HexColor(dataList[index1]
                                                    .category
                                                    .colorCode)),
                                          ),
                                          padding: EdgeInsets.all(8.0))
                                    else
                                      Padding(
                                          child: SubStringHighlight(
                                            text:
                                                '${dataList[index1].category.subcategories[index].subCategoryname}',
                                            term: editingController.text,
                                            textStyle: TextStyle(
                                                fontSize: 18,
                                                color: HexColor(dataList[index1]
                                                    .category
                                                    .colorCode)),
                                          ),
                                          padding: EdgeInsets.all(8.0)),
                                    new ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: dataList[index1]
                                          .category
                                          .subcategories[index]
                                          .items
                                          .length,
                                      itemBuilder: (_, index2) {
                                        if (editingController.text.isEmpty) {
                                          return Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(dataList[index1]
                                                  .category
                                                  .subcategories[index]
                                                  .items[index2]));
                                        } else {
                                          return Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: dataList[index1]
                                                      .category
                                                      .subcategories[index]
                                                      .items[index2]
                                                      .toLowerCase()
                                                      .contains(
                                                          editingController
                                                              .text)
                                                  ? SubStringHighlight(
                                                      text: dataList[index1]
                                                          .category
                                                          .subcategories[index]
                                                          .items[index2],
                                                      term: editingController
                                                          .text,
                                                    )
                                                  : Text(dataList[index1]
                                                      .category
                                                      .subcategories[index]
                                                      .items[index2]));
                                        }
                                      },
                                    )
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      );
                  },
                ),
              ],
            )));
  }
}
