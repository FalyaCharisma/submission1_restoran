import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:submission1_restoran/restoran_detail.dart';
import 'dart:async';
import 'dart:convert';
import './restoran_model.dart';

class Restoran extends StatefulWidget {
  @override
  _RestoranState createState() => new _RestoranState();
}

class _RestoranState extends State<Restoran> {
  List<RestoranModel> _list = [];
  List<RestoranModel> _search = [];
  var loading = false;

  Future<Null> _fetchData()async{
    setState(() {
      loading = true;
    });
    var url = "https://gist.githubusercontent.com/LittleFireflies/e8c08f316217b5018b76b3e5463da34d/raw/bf145725d1d9af2635b71bd6d5d9dc0b79712157/local_restaurant.json";

    _list.clear();
    final response = await http.get(Uri.parse(url));

    if (response.statusCode==200){
      final data = jsonDecode(response.body);

      setState(() {
        for (var i in data['restaurants']){
          _list.add(RestoranModel.fromJson(i));
          loading= false;
        }

      });
    }
  }

  TextEditingController controller = new TextEditingController();

  onSearch(String text) async{
    _search.clear();
    if (text.isEmpty){
      setState(() {});
      return;
    }
    _list.forEach((f) { 
      if(f.name.contains(text)) _search.add(f);
    });
    setState(() {});
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
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.blue,
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.search),
                    title: TextField(
                      controller: controller,
                      onChanged: onSearch,
                      decoration: InputDecoration(
                        hintText: "Search", border: InputBorder.none
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: (){
                        controller.clear();
                        onSearch('');
                      },
                      icon: Icon(Icons.cancel),
                    ),
                  ),
                ),
              ),
              loading ? Center(child: CircularProgressIndicator()):
                Expanded(
                child: _search.length!=0 || controller.text.isNotEmpty ? 
                ListView.builder(
                  itemCount: _search.length,
                  itemBuilder: (context, i){
                    final a = _search[i];
                    return Card(
                color: Colors.white,
                elevation: 2.0,
                child: ListTile(
                  leading: 
                  Image.network(a.pictureId),
                  title: Text(a.name),
                  subtitle: 
                  Text(
                    'Rating: ' + a.rating.toString() + '\n'
                    'City: ' + a.city + '\n'
                  ),
                  onTap:(){
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) => RestoranDetail(_list[i]),
                    );
                       Navigator.push(context, route);
                  },
                ),
              );
                  }
                ) :
                ListView.builder(
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
                  subtitle: 
                  Text(
                    'Rating: ' + x.rating.toString() + '\n'
                    'City: ' + x.city + '\n'
                  ),
                  onTap:(){
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) => RestoranDetail(_list[i]),
                    );
                       Navigator.push(context, route);
                  },
                ),
              );
           },
        ),
                ),
              
            ],
          ),
      ),
    );
  }
}
 