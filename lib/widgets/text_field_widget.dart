import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:provider/provider.dart';

class TextFieldWidget {
  final BuildContext _context;
  final TextEditingController _textEditingController;
  final String _hint;
  final bool _isRegistered, _isPasswordSignIn;
  final IconData _icon;
  final Function _onSaved;

  TextFieldWidget(
    this._context,
    this._textEditingController,
    this._hint,
    this._isRegistered,
    this._isPasswordSignIn,
    this._icon,
    this._onSaved,
  );

  Container createTextFieldWidget() {
    final bool _isEmail = _hint == 'Email',
        _isPassword = _hint == 'Password',
        _isConfirmPassword = _hint == 'Confirm password';
    final SignInProviders _signInProviders =
        Provider.of<SignInProviders>(_context);
    final SignUpProviders _signUpProviders =
        Provider.of<SignUpProviders>(_context);

    return Container(
      height: ContentSizes.height(_context) * 0.06,
      width: ContentSizes.width(_context),
      child: Consumer<AppProviders>(
        builder: (_, AppProviders value, __) {
          return TextFormField(
            initialValue: null,
            controller: _textEditingController,
            cursorColor: Colors.grey,
            keyboardType:
                _isEmail ? TextInputType.emailAddress : TextInputType.text,
            maxLines: 1,
            obscureText: _isEmail
                ? false
                : _isPasswordSignIn
                    ? !_signInProviders.isPasswordSignInVisible
                    : _isPassword
                        ? !_signUpProviders.isPasswordSignUpVisible
                        : !_signUpProviders.isConfirmPasswordVisible,
            validator: _isRegistered
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
                        if (_signUpProviders.passwordSignUp !=
                            _signUpProviders.confirmPassword) {
                          return ContentTexts.passwordDidntMatch;
                        }
                        if (!regex.hasMatch(input)) {
                          return ContentTexts.invalidPassword;
                        }
                      }
                    }
                    return null;
                  },
            onSaved: _onSaved,
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
                          tooltip: _signInProviders.isPasswordSignInVisible
                              ? ContentTexts.hidePassword
                              : ContentTexts.showPassword,
                          icon: _signInProviders.isPasswordSignInVisible
                              ? Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                          onPressed: () {
                            _signInProviders.isPasswordSignInVisible =
                                !_signInProviders.isPasswordSignInVisible;
                          },
                        )
                      : _isPassword
                          ? IconButton(
                              tooltip: _signUpProviders.isPasswordSignUpVisible
                                  ? ContentTexts.hidePassword
                                  : ContentTexts.showPassword,
                              icon: _signUpProviders.isPasswordSignUpVisible
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                              onPressed: () {
                                _signUpProviders.isPasswordSignUpVisible =
                                    !_signUpProviders.isPasswordSignUpVisible;
                              },
                            )
                          : IconButton(
                              tooltip: _signUpProviders.isConfirmPasswordVisible
                                  ? ContentTexts.hideConfirmPassword
                                  : ContentTexts.showConfirmPassword,
                              icon: _signUpProviders.isConfirmPasswordVisible
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                              onPressed: () {
                                _signUpProviders.isConfirmPasswordVisible =
                                    !_signUpProviders.isConfirmPasswordVisible;
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
