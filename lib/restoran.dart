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
    var url = "https://gist.github.com/LittleFireflies/e8c08f316217b5018b76b3e5463da34d#file-local_restaurant-json";
    final response = await http.get(url);
    if (response.statusCode==200){
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data){
          var i;
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
          elevation:0.0,
        ),
        body: Container(
          child: loading ? Center(child: CircularProgressIndicator()):(ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, i){
              final x = _list[i];
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.network(x.pictureId),
                    Text(x.name),
                  ]
                ),
              );
            },
          )),
        ),
      );
    }
  }
  // final String sUrl = "https://gist.github.com/LittleFireflies/e8c08f316217b5018b76b3e5463da34d.js";
  // late List<RestoranModel> listrestoran;

  // @override
  // void initState() {
  //   super.initState();
  // }

  // Future<List<RestoranModel>> _fetchData() async {
  //   var params = "restoran.php";
  //   try {
  //     var sUrl;
  //     var jsonResponse = await http.get(sUrl+params);
  //     if (jsonResponse.statusCode == 200) {
  //       final jsonItems =
  //           json.decode(jsonResponse.body).cast<Map<String, dynamic>>();

  //       listrestoran = jsonItems.map<RestoranModel>((json) {
  //         return RestoranModel.fromJson(json);
  //       }).toList();
  //     }
  //   } catch (e) {}
  //   return listrestoran;
  // }

  // Future<Null> _refresh() {
  //   return _fetchData().then((_listrestoran) {
  //     setState(() => listrestoran);
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return new Scaffold(
  //     appBar: new AppBar(
  //       backgroundColor: Colors.orange,
  //       title: Text(' Data Restoran'),
  //     ),
  //     body: RefreshIndicator(
  //       onRefresh: _refresh,
  //       child: FutureBuilder<List<RestoranModel>>(
  //         future: _fetchData(),
  //         builder: (context, snapshot) {
  //           if (!snapshot.hasData)
  //             return Center(child: CircularProgressIndicator());
  //           return Container(
  //             margin: EdgeInsets.only(bottom: 0.0),
  //             child: ListView(
  //               padding: EdgeInsets.only(bottom: 160.0),
  //               children: snapshot.data!.map(
  //                     (_data) => Column(children: <Widget>[
  //                       Card(
  //                         child: Column(
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: <Widget>[
  //                             ListTile(
  //                               leading: Icon(Icons.perm_media, size: 50),
  //                               title: Text(_data.name),
  //                               subtitle:
  //                                   Text(_data.city),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ]),
  //                   )
  //                   .toList(),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(IterableProperty<RestoranModel>('listrestoran', listrestoran));
  // }
