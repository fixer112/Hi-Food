import 'package:flutter/material.dart';

class Resturants extends StatelessWidget {
  final resturants = [
    { 'name': 'Mamm-ma', 'image': 'https://media-cdn.tripadvisor.com/media/photo-s/10/f4/ee/c0/front-view-of-ihop-restaurant.jpg', 'tagline': 'the taste differs' },
    { 'name': 'Agbado Express', 'image': 'https://media-cdn.tripadvisor.com/media/photo-s/08/94/f0/ad/indrapura.jpg', 'tagline': 'experience a new expression' },
    { 'name': 'Sweet Sensation', 'image': 'https://www.nairaland.com/attachments/6426951_sweetsensation_jpeg1a0801e521a50430b8009ac88fd5c6a0', 'tagline': 'sensation all the way' },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(6.0),
      children: <Widget>[
        Container(
          color: Colors.grey,
          padding: EdgeInsets.all(8.0),
          height: 55.0,
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon( Icons.search ),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(),
              labelText: 'Search'
            ),
          ),
        ),
        SizedBox(height: 10.0,),
        Column(
          children: List.generate(resturants.length, (int index){
            return Card(
              elevation: 4.0,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 85.0,
                    width: 85.0,
                    child: FittedBox(
                      child: Image.network( resturants[index]['image'] ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox( width: 15.0, ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text( resturants[index]['name'], style: TextStyle( fontWeight: FontWeight.bold, fontSize: 16.0 ), ),
                      Text( '...'+resturants[index]['tagline'], style: TextStyle( fontStyle: FontStyle.italic ), ),
                      SizedBox(height: 15.0,),
                      Row(
                        children: <Widget>[
                          Icon( Icons.star, color: Color(0xFFF18A11), size: 20, ),
                          Icon( Icons.star, color: Color(0xFFF18A11), size: 20, ),
                          Icon( Icons.star, color: Color(0xFFF18A11), size: 20, ),
                          Icon( Icons.star, color: Color(0xFFF18A11), size: 20, ),
                          Icon( Icons.star, color: Colors.grey, size: 20, ),
                          Text( ' (4.5K)', style: TextStyle( fontSize: 13 ), )
                        ],
                      ),
                    ]
                  )
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}