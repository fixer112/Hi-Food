import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  Cart(this.size, {Key key}) : super(key: key);
  final double size;
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Icon(
          Icons.shopping_cart,
          size: widget.size,
          color: Colors.white,
        ),
      ),
    );
  }
}
