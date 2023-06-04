import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:foodorder_app/models/product_model.dart';
import 'package:foodorder_app/screens/search/SearchItem.dart';
import 'package:foodorder_app/screens/widgets/SingleItem.dart';

class Search extends StatefulWidget {
  final List<ProductModel>? search;
  Search({this.search});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = "";

  searchItem(String query) {
    List<ProductModel> searchFood = widget.search?.where((element) {
          return element.productName!.toLowerCase().contains(query);
        }).toList() ??
        [];
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> _searchItem = searchItem(query);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(2, 134, 17, 1),
        title: Text('Search'),
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: Icon(Icons.menu_rounded),
        //   )
        // ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
                fillColor: Color.fromARGB(255, 237, 237, 237),
                filled: true,
                hintText: 'Tìm kiếm',
                alignLabelWithHint: true,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.search,
                    size: 35,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView(
            children: _searchItem.map((data) {
              return SearchItem(
                productImage: data.productImage,
                productName: data.productName,
                productPrice: data.productPrice,
              );
            }).toList(),
          ))
        ],
      ),
    );
  }
}
