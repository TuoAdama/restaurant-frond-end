import 'package:flutter/material.dart';
import 'package:restaurant/layouts/ItemCategory.dart';
import 'package:restaurant/models/Category.dart';


typedef OnItemCategorySelected = void Function(Category);

class ItemCategoryList extends StatelessWidget {
  const ItemCategoryList({
    Key? key,
    required this.categories,
    required this.onSelected,
    this.selectedColor = const Color(0xFFFF4130),
    this.initialIndex = 0,
  }) : super(key: key);

  final List<Category> categories;
  final OnItemCategorySelected onSelected;
  final int initialIndex;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18.0),
      height: 120,
      child: ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.0,),
        itemBuilder: (_, int i) => SizedBox(
          width: 100,
          child: ItemCategory(
            category: categories[i], 
            onSelect: onSelected,
            isSelect: i == initialIndex,
            selectColor: selectedColor,
          ),
        ),
      ),
    );
  }
}