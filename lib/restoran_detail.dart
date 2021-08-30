import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:submission1_restoran/restoran_model.dart';

class RestoranDetail extends StatelessWidget{
  late final RestoranModel restoran;

  RestoranDetail(this.restoran);

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Restaurant"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.only(bottom:8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    height: 30,
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(restoran.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: Image.network(restoran.pictureId),
                  ),
                  RatingBar.builder(
                    initialRating: restoran.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 15,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                      ),
                    onRatingUpdate: (rating){
                      print(rating);
                    },
                  ),
                  Text("City: " + restoran.city, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Container(
                    child: Text(restoran.description),
                    padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    height: 30,
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Menu Makanan: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  for(var food in restoran.menu.foods)
                  Text(food.name),
                  Container(
                    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    height: 30,
                    color: Colors.blue,
                    child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Menu Minuman: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  for(var drink in restoran.menu.drinks)
                    Text(drink.name),
                ],
              ),
            ),
          ),
        ),
    );
  }
}