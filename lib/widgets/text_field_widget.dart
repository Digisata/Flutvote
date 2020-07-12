import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:provider/provider.dart';

class TextFieldWidget {
  final BuildContext _context;
  final TextEditingController _textEditingController;
  final String _hint;
  final IconData _icon;

  TextFieldWidget(
    this._context,
    this._textEditingController,
    this._hint,
    this._icon,
  );

  Container createTextFieldWidget() {
    return Container(
      height: ContentSizes.height(_context) * 0.06,
      width: ContentSizes.width(_context),
      child: Consumer<AppProviders>(
        builder: (_, AppProviders value, __) {
          return TextField(
            controller: _textEditingController,
            cursorColor: Colors.grey,
            keyboardType: TextInputType.emailAddress,
            obscureText: _hint != 'Password' ? false : !value.isPasswordVisible,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: _hint,
              prefixIcon: Icon(
                _icon,
                color: Colors.grey,
              ),
              suffixIcon: _hint != 'Password'
                  ? Icon(
                      Icons.visibility,
                      color: Colors.transparent,
                    )
                  : IconButton(
                      tooltip: value.isPasswordVisible
                          ? ContentTexts.hidePassword
                          : ContentTexts.showPassword,
                      icon: value.isPasswordVisible
                          ? Icon(
                              Icons.visibility,
                              color: Colors.grey,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            ),
                      onPressed: () {
                        value.showHidePassword();
                      },
                    ),
              fillColor: ColorPalettes.backgroundGrey,
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
          );
        },
      ),
    );
  }
}
