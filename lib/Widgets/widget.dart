import 'package:flutter/material.dart';
import '../colors/appcolor.dart';

PreferredSizeWidget topbar() {
  return AppBar(
    backgroundColor: bgColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.menu,
          color: iconCOlor,
          size: 30,
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset('assets/images/img.png'),
          ),
        ),
      ],
    ),
  );
}

Widget searchbar(Function(String) runFilter) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: iconCOlor,
      borderRadius: BorderRadius.circular(15),
    ),
    child: TextField(
      onChanged: (value) => runFilter(value),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0),
        prefixIcon: Icon(
          Icons.search,
          size: 20,
          color: bgColor,
        ),
        prefixIconConstraints: BoxConstraints(
          maxHeight: 20,
          minWidth: 25,
        ),
        border: InputBorder.none,
        hintText: 'Search',
        hintStyle: TextStyle(color: bgColor),
      ),
    ),
  );
}
