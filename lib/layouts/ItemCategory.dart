import 'package:flutter/material.dart';
import 'package:restaurant/data/utilisies.dart';
import 'package:restaurant/models/Category.dart';

typedef OnItemCategorySelected = void Function(Category);

class ItemCategory extends StatelessWidget {
  const ItemCategory({
    Key? key,
    required this.category,
    required this.onSelect,
    required this.isSelect,
    required this.selectColor,
  }) : super(key: key);

  final Category category;
  final OnItemCategorySelected onSelect;
  final bool isSelect;
  final Color selectColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9.0),
      child: Material(
        color: !isSelect ? Colors.grey.shade100 : selectColor,
        child: InkWell(
          onTap: () => onSelect(category),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                 Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(Utilisies.host+"${category.avatar}"),
                                //NetworkImage(Utilisies.host+"${category.avatar}"),
                            fit: BoxFit.cover)),
                  ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      category.libelle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: !isSelect ? null : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}