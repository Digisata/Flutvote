import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:provider/provider.dart';

class TextFieldWidget {
  Container createTextFieldWidget(
    BuildContext _context,
    TextEditingController _textEditingController,
    String _hint,
    IconData _icon,
    Function _onSaved, {
    bool isRegistered = false,
    isSignUp = false,
    isEmail = false,
    isPasswordSignIn = false,
    isPasswordSignUp = false,
    isSetupProfile = false,
    isEditProfile = false,
    isUsername = false,
    isDisplayName = false,
    isOldPassword = false,
    isNewPassword = false,
    isRepeatPasswordSignUp = false,
    isRepeatChangePassword = false,
  }) {
    final SignInProviders _signInProviders =
        Provider.of<SignInProviders>(_context);
    final SignUpProviders _signUpProviders =
        Provider.of<SignUpProviders>(_context);
    final ChangePasswordProviders _changePasswordProviders =
        Provider.of<ChangePasswordProviders>(_context);
    final bool _isPassword = isPasswordSignUp ||
            isRepeatPasswordSignUp ||
            isNewPassword ||
            isRepeatChangePassword,
        _isPlainText = isEmail || isSetupProfile || isEditProfile;

    return Container(
      height: ContentSizes.height(_context) * 0.06,
      width: ContentSizes.width(_context),
      child: TextFormField(
        controller: _textEditingController,
        cursorColor: Colors.grey,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        maxLines: 1,
        obscureText: _isPlainText
            ? false
            : isPasswordSignIn
                ? !_signInProviders.isPasswordSignInVisible
                : isPasswordSignUp
                    ? !_signUpProviders.isPasswordSignUpVisible
                    : isOldPassword
                        ? !_changePasswordProviders.isOldPasswordChangeVisible
                        : isNewPassword
                            ? !_changePasswordProviders
                                .isNewPasswordChangeVisible
                            : isRepeatPasswordSignUp
                                ? !_signUpProviders
                                    .isRepeatPasswordSignUpVisible
                                : !_changePasswordProviders
                                    .isNewRepeatPasswordChangeVisible,
        validator: isRegistered
            ? (input) {
                if (input.isEmpty) {
                  return 'Please input your ${_hint.toLowerCase()}!';
                }
                return null;
              }
            : (input) {
                if (input.isEmpty) {
                  if (isSetupProfile) {
                    return isDisplayName
                        ? 'Please input ${ContentTexts.displayName.toLowerCase()}'
                        : 'Please input ${ContentTexts.username.toLowerCase()}';
                  } else {
                    if (!isEditProfile) {
                      return 'Please input ${_hint.toLowerCase()}!';
                    }
                  }
                } else {
                  if (isEmail) {
                    if (!EmailValidator.validate(input)) {
                      return ContentTexts.invalidEmailAddress;
                    }
                  } else if (isUsername) {
                    Pattern pattern =
                        r'^(?=.{6,15}$)(?![_])(?!.*[_]{2})[a-zA-Z0-9_]+(?<![_])$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(input)) {
                      return ContentTexts.invalidUsername;
                    }
                  } else if (_isPassword) {
                    Pattern pattern =
                        r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,20}$';
                    RegExp regex = new RegExp(pattern);
                    if (isSignUp) {
                      if (_signUpProviders.passwordSignUp !=
                          _signUpProviders.repeatPasswordSignUp) {
                        return ContentTexts.passwordDidntMatch;
                      }
                    } else {
                      if (_changePasswordProviders.newPasswordChange !=
                          _changePasswordProviders.newRepeatPasswordChange) {
                        return ContentTexts.passwordDidntMatch;
                      }
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
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: _hint,
          errorMaxLines: 2,
          prefixIcon: Icon(
            _icon,
            color: Colors.grey,
          ),
          suffixIcon: _isPlainText
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
                  : isPasswordSignUp
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
                      : isOldPassword
                          ? IconButton(
                              tooltip: _changePasswordProviders
                                      .isOldPasswordChangeVisible
                                  ? ContentTexts.hidePassword
                                  : ContentTexts.showPassword,
                              icon: _changePasswordProviders
                                      .isOldPasswordChangeVisible
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                              onPressed: () {
                                _changePasswordProviders
                                        .isOldPasswordChangeVisible =
                                    !_changePasswordProviders
                                        .isOldPasswordChangeVisible;
                              },
                            )
                          : isNewPassword
                              ? IconButton(
                                  tooltip: _changePasswordProviders
                                          .isNewPasswordChangeVisible
                                      ? ContentTexts.hidePassword
                                      : ContentTexts.showPassword,
                                  icon: _changePasswordProviders
                                          .isNewPasswordChangeVisible
                                      ? Icon(
                                          Icons.visibility,
                                          color: Colors.grey,
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                  onPressed: () {
                                    _changePasswordProviders
                                            .isNewPasswordChangeVisible =
                                        !_changePasswordProviders
                                            .isNewPasswordChangeVisible;
                                  },
                                )
                              : isRepeatPasswordSignUp
                                  ? IconButton(
                                      tooltip: _signUpProviders
                                              .isRepeatPasswordSignUpVisible
                                          ? ContentTexts.hideRepeatPassword
                                          : ContentTexts.showRepeatPassword,
                                      icon: _signUpProviders
                                              .isRepeatPasswordSignUpVisible
                                          ? Icon(
                                              Icons.visibility,
                                              color: Colors.grey,
                                            )
                                          : Icon(
                                              Icons.visibility_off,
                                              color: Colors.grey,
                                            ),
                                      onPressed: () {
                                        _signUpProviders
                                                .isRepeatPasswordSignUpVisible =
                                            !_signUpProviders
                                                .isRepeatPasswordSignUpVisible;
                                      },
                                    )
                                  : IconButton(
                                      tooltip: _changePasswordProviders
                                              .isNewRepeatPasswordChangeVisible
                                          ? ContentTexts.hideRepeatPassword
                                          : ContentTexts.showRepeatPassword,
                                      icon: _changePasswordProviders
                                              .isNewRepeatPasswordChangeVisible
                                          ? Icon(
                                              Icons.visibility,
                                              color: Colors.grey,
                                            )
                                          : Icon(
                                              Icons.visibility_off,
                                              color: Colors.grey,
                                            ),
                                      onPressed: () {
                                        _changePasswordProviders
                                                .isNewRepeatPasswordChangeVisible =
                                            !_changePasswordProviders
                                                .isNewRepeatPasswordChangeVisible;
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
