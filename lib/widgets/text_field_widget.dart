import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:provider/provider.dart';

class TextFieldWidget {
  final BuildContext _context;
  final TextEditingController _textEditingController;
  final String _hint;
  final IconData _icon;
  final Function _onSaved;
  final bool isRegistered, isPasswordSignIn;

  TextFieldWidget(
    this._context,
    this._textEditingController,
    this._hint,
    this._icon,
    this._onSaved, {
    this.isRegistered = false,
    this.isPasswordSignIn = false,
  });

  Container createTextFieldWidget() {
    final bool _isEmail = _hint == 'Email',
        _isPassword = _hint == 'Password',
        _isRepeatPassword = _hint == 'Repeat password';
    final SignInProviders _signInProviders =
        Provider.of<SignInProviders>(_context);
    final SignUpProviders _signUpProviders =
        Provider.of<SignUpProviders>(_context);

    return Container(
      height: ContentSizes.height(_context) * 0.06,
      width: ContentSizes.width(_context),
      child: TextFormField(
        controller: _textEditingController,
        cursorColor: Colors.grey,
        keyboardType:
            _isEmail ? TextInputType.emailAddress : TextInputType.text,
        maxLines: 1,
        obscureText: _isEmail
            ? false
            : isPasswordSignIn
                ? !_signInProviders.isPasswordSignInVisible
                : _isPassword
                    ? !_signUpProviders.isPasswordSignUpVisible
                    : !_signUpProviders.isRepeatPasswordVisible,
        validator: isRegistered
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
                  } else if (_isPassword || _isRepeatPassword) {
                    Pattern pattern =
                        r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                    RegExp regex = new RegExp(pattern);
                    if (_signUpProviders.passwordSignUp !=
                        _signUpProviders.repeatPassword) {
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
        textInputAction: _isEmail ? TextInputAction.next : TextInputAction.done,
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
              : isPasswordSignIn
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
                          tooltip: _signUpProviders.isRepeatPasswordVisible
                              ? ContentTexts.hideRepeatPassword
                              : ContentTexts.showRepeatPassword,
                          icon: _signUpProviders.isRepeatPasswordVisible
                              ? Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                          onPressed: () {
                            _signUpProviders.isRepeatPasswordVisible =
                                !_signUpProviders.isRepeatPasswordVisible;
                          },
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
      ),
    );
  }
}
