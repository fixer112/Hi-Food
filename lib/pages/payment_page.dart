import 'package:flutter/material.dart';

import 'package:hi_food/values.dart';

class TestPayment extends StatefulWidget {
  _TestPaymentState createState() => _TestPaymentState();
}

class _TestPaymentState extends State<TestPayment> {
  final _key = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _orderedFoodWidget() {
    return Container(
      padding: EdgeInsets.only(left: 24),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Jollof Rice with Chicken and Salad',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          Text(
            '\$2000',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Checkout'),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[

                SizedBox(height: 40),

                _orderedFoodWidget(),

                SizedBox(height: 40),

                CardFormWidget(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 50,
              child: FlatButton(
                color: primaryColor,
                onPressed: () => snackbar('Payment Sucessful', context, _scaffoldKey),
                child: Text(
                  'PAY NOW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardFormWidget extends StatefulWidget {
  @override
  _CardFormWidgetState createState() => _CardFormWidgetState();
}

class _CardFormWidgetState extends State<CardFormWidget> {
  final _cardNumber = Container(
    alignment: Alignment.centerLeft,
    child: Text(
      'Card Number',
      style: TextStyle(
        fontSize: 15,
      ),
    ),
  );

  final _cardName = Container(
    alignment: Alignment.centerLeft,
    child: Text(
      'Card Holder\'s Name',
      style: TextStyle(
        fontSize: 15,
      ),
    ),
  );

  final _expiryDate = Container(
    alignment: Alignment.centerLeft,
    child: Text(
      'Expiry Date',
      style: TextStyle(
        fontSize: 15,
      ),
    ),
  );

  final _cVC = Container(
    alignment: Alignment.centerLeft,
    child: Text(
      'CVC',
      style: TextStyle(
        fontSize: 15,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: <Widget>[
          _cardNumber,
          SizedBox(height: 8),
          _buildCardNumberField(),
          SizedBox(height: 15),
          _cardName,
          SizedBox(height: 8),
          _buildHoldersNameField(),
          SizedBox(height: 15),
          Container(
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Column(
                    children: <Widget>[
                      _expiryDate,
                      SizedBox(height: 8),
                      _buildExpiryDateField(),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Flexible(
                  child: Column(
                    children: <Widget>[
                      _cVC,
                      SizedBox(height: 8),
                      _buildCVCField(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildCardNumberField() {
    return TextFormField(
      initialValue: '5399 0000 0000 0000',
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        isDense: true,
      ),
    );
  }

  _buildHoldersNameField() {
    return TextFormField(
      initialValue: 'John Doe',
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        isDense: true,
      ),
    );
  }

  _buildExpiryDateField() {
    return TextFormField(
      initialValue: '11/11',
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        isDense: true,
      ),
    );
  }

  _buildCVCField() {
    return TextFormField(
      initialValue: '***',
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}


