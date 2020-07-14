import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:provider/provider.dart';

class TextFieldWidget {
  final BuildContext _context;
  final TextEditingController _textEditingController;
  final String _hint;
  final bool _isSignIn, _isPasswordSignIn;
  final IconData _icon;

  TextFieldWidget(
    this._context,
    this._textEditingController,
    this._hint,
    this._isSignIn,
    this._isPasswordSignIn,
    this._icon,
  );

  Container createTextFieldWidget() {
    final bool _isEmail = _hint == 'Email',
        _isPassword = _hint == 'Password',
        _isConfirmPassword = _hint == 'Confirm password';

    return Container(
      height: ContentSizes.height(_context) * 0.06,
      width: ContentSizes.width(_context),
      child: Consumer<AppProviders>(
        builder: (_, AppProviders value, __) {
          return TextFormField(
            controller: _textEditingController,
            cursorColor: Colors.grey,
            keyboardType:
                _isEmail ? TextInputType.emailAddress : TextInputType.text,
            maxLines: 1,
            obscureText: _isEmail
                ? false
                : _isPasswordSignIn
                    ? !value.isPasswordSignInVisible
                    : _isPassword
                        ? !value.isPasswordSignUpVisible
                        : !value.isConfirmPasswordVisible,
            validator: _isSignIn
                ? (input) {
                    if (input.isEmpty) {
                      return 'Please input your ${_hint.toLowerCase()}!';
                    }
                    return null;
                  }
                : (input) {
                    if (input.isEmpty) {
                      return 'Please input ${_hint.toLowerCase()}!';
                    } else {
                      if (_isEmail) {
                        if (!EmailValidator.validate(input)) {
                          return ContentTexts.invalidEmailAddress;
                        }
                      } else if (_isPassword || _isConfirmPassword) {
                        Pattern pattern =
                            r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                        RegExp regex = new RegExp(pattern);
                        if (value.passwordInput != value.confirmPasswordInput) {
                          return ContentTexts.passwordDidntMatch;
                        }
                        if (!regex.hasMatch(input)) {
                          return ContentTexts.invalidPassword;
                        }
                      }
                    }
                    return null;
                  },
            textAlign: TextAlign.start,
            textDirection: TextDirection.ltr,
            textInputAction:
                _isEmail ? TextInputAction.next : TextInputAction.done,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: _hint,
              errorMaxLines: 2,
              prefixIcon: Icon(
                _icon,
                color: Colors.grey,
              ),
              suffixIcon: _isEmail
                  ? Icon(
                      Icons.visibility,
                      color: Colors.transparent,
                    )
                  : _isPasswordSignIn
                      ? IconButton(
                          tooltip: value.isPasswordSignInVisible
                              ? ContentTexts.hidePassword
                              : ContentTexts.showPassword,
                          icon: value.isPasswordSignInVisible
                              ? Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                          onPressed: () {
                            value.isPasswordSignInVisible =
                                !value.isPasswordSignInVisible;
                          },
                        )
                      : _isPassword
                          ? IconButton(
                              tooltip: value.isPasswordSignUpVisible
                                  ? ContentTexts.hidePassword
                                  : ContentTexts.showPassword,
                              icon: value.isPasswordSignUpVisible
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                              onPressed: () {
                                value.isPasswordSignUpVisible =
                                    !value.isPasswordSignUpVisible;
                              },
                            )
                          : IconButton(
                              tooltip: value.isConfirmPasswordVisible
                                  ? ContentTexts.hideConfirmPassword
                                  : ContentTexts.showConfirmPassword,
                              icon: value.isConfirmPasswordVisible
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                              onPressed: () {
                                value.isConfirmPasswordVisible =
                                    !value.isConfirmPasswordVisible;
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
