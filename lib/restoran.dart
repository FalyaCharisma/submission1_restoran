import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import './restoran_model.dart';

class Restoran extends StatefulWidget {
  @override
  _RestoranState createState() => new _RestoranState();
}

class _RestoranState extends State<Restoran> {
  List<RestoranModel> _list = [];
  var loading = false;

  Future<Null> _fetchData()async{
    setState(() {
      loading = true;
    });
    var url = "https://gist.githubusercontent.com/LittleFireflies/e8c08f316217b5018b76b3e5463da34d/raw/bf145725d1d9af2635b71bd6d5d9dc0b79712157/local_restaurant.json";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode==200){
      final data = jsonDecode(response.body);

      setState(() {
        for (var i in data['restaurants']){
          _list.add(RestoranModel.fromJson(i));
        }

        loading= false;
      });
    }
  }

  @override 
  void initState(){
    super.initState();
    _fetchData();
  }

  @override 
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text("Restaurant"),
          elevation:0.0,
        ),
        body: Container(
          child: loading ? Center(child: CircularProgressIndicator()):(ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, i){
              final x = _list[i];
              return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: 
              Image.network(x.pictureId),
              title: Text(x.name),
              subtitle: Text(
                'Rating = ' + x.rating.toString(),
              ),
              onTap:(){
               
              },
            ),
          );
         },
        )),
      ),
    );
  }
}
 