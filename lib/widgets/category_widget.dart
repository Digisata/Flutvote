import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:provider/provider.dart';

class CategoryWidget {
  ListView createCategoryWidget(BuildContext _context) {
    final HomeProviders _homeProvider = Provider.of<HomeProviders>(_context);
    final List<String> _categoriesList = [
      'All',
      'Fashion',
      'Food',
      'Travel',
      'All',
      'Fashion',
      'Food',
      'Travel',
    ];

    return ListView.builder(
      itemCount: _categoriesList.length,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: ContentSizes.width(_context) * 0.05),
      itemBuilder: (context, index) {
        bool _isSelectedCategory = _homeProvider.selectedCategoryIndex == index;
        return Padding(
          padding: EdgeInsets.all(ContentSizes.height(context) * 0.003),
          child: GestureDetector(
            child: Container(
              height: ContentSizes.height(context) * 0.3,
              width: ContentSizes.width(context) * 0.2,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(
                ContentSizes.width(context) * 0.01,
                ContentSizes.height(context) * 0.005,
                ContentSizes.width(context) * 0.01,
                ContentSizes.height(context) * 0.005,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                shape: BoxShape.rectangle,
                color: !_isSelectedCategory
                    ? Colors.transparent
                    : ContentColors.orange,
              ),
              child: Text(
                _categoriesList[index],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: !_isSelectedCategory
                          ? ContentColors.grey
                          : ContentColors.white,
                      fontSize: ContentSizes.dp16(context),
                    ),
              ),
            ),
            onTap: () {
              _homeProvider.selectedCategoryIndex = index;
            },
          ),
        );
      },
    );
  }
}
