import 'package:flutter/material.dart';
import 'package:hi_food/values.dart';
import 'package:hi_food/widgets/search.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Foods extends StatefulWidget {
  Foods({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FoodsState createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  final List<bool> isSelected = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  final double btnRadius = 5;
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    final demoLister = Card(
      elevation: 4.0,
      child: InkWell(
        splashColor: primaryColor,
        onTap: () {
          print('Card tapped.');
        },
        child: Column(
          children: <Widget>[
            Image.network(
              'https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
              height: 120.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              child: Column(children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Sharwama',
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        'N1000.00',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ]),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: <Widget>[
                    SmoothStarRating(
                        allowHalfRating: true,
                        onRatingChanged: (v) {
                          //rating = v;
                          //setState(() {});
                        },
                        starCount: 5,
                        rating: 4.1,
                        size: 20.0,
                        color: ratingColor,
                        borderColor: primaryColor,
                        spacing: 0.0),
                    Text(
                      ' (50)',
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                )
              ]),
            ),
          ],
        ),
      ),
    );

    final productList = () {
      return Column(
          children: List.generate(5, (int index) {
        return Card(
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Huevos Sandwich',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          )),
                      SizedBox(
                        height: 3,
                      ),
                      Text('N100.00',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w300)),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          SmoothStarRating(
                              allowHalfRating: true,
                              onRatingChanged: (v) {
                                //rating = v;
                                //setState(() {});
                              },
                              starCount: 5,
                              rating: 4.3,
                              size: 20.0,
                              color: ratingColor,
                              borderColor: primaryColor,
                              spacing: 0.0),
                          Text(
                            ' (50)',
                            style: TextStyle(fontSize: 13),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '- Sweet Sensation',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 12.0),
                      )
                    ]),
                Container(
                    height: 100.0,
                    width: 100.0,
                    child: FittedBox(
                      child: Image.network(
                          'https://images.pexels.com/photos/461198/pexels-photo-461198.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                      fit: BoxFit.cover,
                    ))
              ],
            ),
          ),
        );
      }));
    };

    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Search('food'),
          SizedBox(
            height: 15.0,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(width: 4.0, color: primaryColor),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'RECENT',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                RaisedButton(
                  color: primaryColor,
                  textColor: Colors.white,
                  onPressed: () {},
                  child: const Text('VIEW ALL', style: TextStyle(fontSize: 15)),
                )
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(6, (int index) {
                return Container(width: 200.0, child: demoLister);
              }),
            ),
          ),
          /* SizedBox( height: 15.0, ),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  color: Color(0xFFD7D7D7),
                  textColor: Colors.black,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(0)
                  ),
                  onPressed: () {},
                  child: Container(
                    padding: EdgeInsets.only( top: 18.0, bottom: 18.0, ),
                    child: Text(
                      'FOODS',
                      style: TextStyle(fontSize: 15)
                    ),
                  )
                ),
              ),
              Expanded(
                child: RaisedButton(
                  color: Colors.pink,
                  textColor: Colors.white,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(0)
                  ),
                  onPressed: () {},
                  child: Container(
                    padding: EdgeInsets.only( top: 18.0, bottom: 18.0 ),
                    child: Text(
                      'RESTURANTS',
                      style: TextStyle(fontSize: 15)
                    ),
                  )
                ),
              ),
            ],
          ), */
          SizedBox(
            height: 10.0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              alignment: Alignment.centerLeft,
              child: ToggleButtons(
                selectedColor: Colors.white,
                fillColor: primaryColor,
                children: List.generate(10, (int index) {
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text([
                      'ALL',
                      'RICE',
                      'HAMBURGER',
                      'DESERT',
                      'TEA'
                    ][index % 5]),
                  );
                }),
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < isSelected.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = true;
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                  });
                },
                isSelected: isSelected,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          productList(),
        ],
      ),
    );
  }
}
