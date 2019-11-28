import 'package:flutter/material.dart';
import 'package:hi_food/values.dart';

class Favourites extends StatefulWidget {
  Favourites({Key key}) : super(key: key);

  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Favourites'),
          bottom: TabBar(
            onTap: (int) {},
            tabs: [
              Tab(icon: Icon(Icons.fastfood)),
              Tab(icon: Icon(Icons.restaurant_menu))
            ],
          ),
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            FavouritesSingleView({
              0: {
                'name': 'Rice & Beans',
                'price': 500,
                'avgRate': 4.6
              }
            }),
            FavouritesSingleView({
              0: {
                'name': 'Rice & Beans',
                'avgRate': 4.6,
                'location': 1.2
              }
            })
          ],
        ),
      ),
    );
  }
}

class FavouritesSingleView extends StatefulWidget {
  final Map<dynamic, dynamic> items;

  FavouritesSingleView(this.items, {Key key}) : super(key: key);

  _FavouritesSingleViewState createState() => _FavouritesSingleViewState();
}

class _FavouritesSingleViewState extends State<FavouritesSingleView> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(6, (int index){
        var item = widget.items[0];
        return Card(
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {},
              splashColor: primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            item['name'].length > 22
                                ? item['name'].substring(0, 22).toUpperCase() + '...'
                                : item['name'].toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            )),
                        SizedBox(
                          height: 3,
                        ),
                        Text( item['price']==null ? '' : 'N'+item['price'].toString(),
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w300)),
                        item['location']==null ? Container() : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon( Icons.location_on, color: ratingColor, ),
                            Text(item['location'].toString()+'km'),
                          ],
                        ),
                        SizedBox(
                          height: item['location']==null ? 15 : 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon( Icons.star, color: ratingColor, ),
                            Text('('+item['avgRate'].toString()+')'),
                          ],
                        ),
                      ]),
                  Container(
                    height: 100.0,
                    width: 100.0,
                    child: FittedBox(
                      child: FlutterLogo(),
                      /*CachedNetworkImage(
                        //height: 50.0,
                        imageUrl: item['image'],
                        placeholder: (context, url) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            backgroundColor: primaryColor,
                          ),
                        ),
                        errorWidget: (context, url, error) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.error,
                            color: primaryColor,
                          ),
                        ),
                      ),*/
                      fit: BoxFit.cover,
                    )
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}