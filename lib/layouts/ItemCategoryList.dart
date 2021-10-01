import 'package:flutter/material.dart';
import 'package:restaurant/layouts/ItemCategory.dart';
import 'package:restaurant/models/Category.dart';

typedef OnItemCategorySelected = void Function(Category);

class ItemCategoryList extends StatefulWidget {
  ItemCategoryList({
    Key? key,
    required this.categories,
    required this.onSelected,
    this.selectedColor = const Color(0xFFFF4130),
    this.initialIndex = 2,
  }) : super(key: key);

  final List<Category> categories;
  final OnItemCategorySelected onSelected;
  int initialIndex;
  final Color selectedColor;

  @override
  ItemCategoryListState createState() => ItemCategoryListState();
}

class ItemCategoryListState extends State<ItemCategoryList> {
  int initialIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  void reset() {
    setState(() {
      initialIndex = -1;
    });
  }



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
        itemCount: widget.categories.length,
        separatorBuilder: (_, __) => SizedBox(
          width: 12.0,
        ),
        itemBuilder: (context, int i) => SizedBox(
          width: 100,
          child: ItemCategory(
            category: widget.categories[i],
            onSelect: (Category cat) {
              if (i != initialIndex) {
                setState(() {
                  initialIndex = i;
                  widget.onSelected(cat);
                });
              }else{
                setState(() {
                  initialIndex = -1;
                });
              }
            },
            isSelect: i == initialIndex,
            selectColor: widget.selectedColor,
          ),
        ),
      ),
    );
  }

}
