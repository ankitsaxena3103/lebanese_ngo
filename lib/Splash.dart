import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'search_and_view_data_screen.dart';
import 'package:http/http.dart'as http;

import 'getjsonclass.dart';
class Splash extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return MySplashState();
  }

}
class MySplashState extends State<Splash> {
  List<Categories> dataList = new List<Categories>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    // TODO: implement build
    return Scaffold(

      body: Container(
          height: size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome ',
                style: new TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
      ),
    );
  }

  @override
  void initState() {
    // call once when instance created
    super.initState();
    getDataFromServer();

    Future.delayed(Duration(seconds: 4), () {


      /*    Route route = MaterialPageRoute(builder: (context) => MyLoginpage());
      Navigator.pushReplacement(context, route);*/
       Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Search_With_Load_data_From_Server(categoriesList: dataList,),
          ));
    });
  }
  Future<List<Categories>> getDataFromServer() async {

      final response = await http.get(
        'https://api.jsonbin.io/b/5fce7e1e2946d2126fff85f0',
      );
      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var rest = data["categories"] as List;
        print(rest);

        rest.forEach((v) {
          dataList.add(new Categories.fromJson(v));
        });
        /* list = rest.map<EmployeeModel>((json) =>
           EmployeeModel.fromJson(json)).toList();*/

      }
      print("List1111 Size: ${dataList.length}");
      dataList.insert(4, Categories());
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Search_With_Load_data_From_Server(categoriesList: dataList,),
          ));

  }

}