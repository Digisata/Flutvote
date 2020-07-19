import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:provider/provider.dart';

class SearchBarWidget {
  Container createSearchBarWidget(
    BuildContext _context,
    TextEditingController _textEditingController,
  ) {
    final HomeProviders _homeProviders = Provider.of<HomeProviders>(_context);

    return Container(
      height: ContentSizes.height(_context) * 0.06,
      width: ContentSizes.width(_context),
      child: TextFormField(
        controller: _textEditingController,
        cursorColor: ContentColors.grey,
        keyboardType: TextInputType.text,
        maxLines: 1,
        textAlign: TextAlign.start,
        textDirection: TextDirection.ltr,
        textInputAction: TextInputAction.done,
        validator: (input) {
          if (input.isEmpty) {
            return 'Please input search!';
          }
          return null;
        },
        onSaved: (input) {},
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: ContentTexts.search,
          prefixIcon: Icon(
            Icons.search,
            color: ContentColors.grey,
          ),
          suffixIcon: _homeProviders.searchKeyword.isNotEmpty
              ? IconButton(
                  tooltip: ContentTexts.clearSearch,
                  icon: Icon(
                    Icons.clear,
                    color: ContentColors.grey,
                  ),
                  onPressed: () {
                    _textEditingController.clear();
                    _homeProviders.searchKeyword = '';
                  },
                )
              : Icon(
                  Icons.clear,
                  color: Colors.transparent,
                ),
          fillColor: ContentColors.backgroundGrey,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (input) {
          _homeProviders.searchKeyword = input.trim();
        },
      ),
    );
  }
}
