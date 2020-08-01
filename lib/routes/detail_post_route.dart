import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/model/models.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class DetailPostRoute extends StatelessWidget {
  final PhotoProfileWidget _photoProfileWidget = PhotoProfileWidget();
  final AlertDialogWidget _alertDialogWidget = AlertDialogWidget();
  final ActionButtonWidget _actionButtonWidget = ActionButtonWidget();
  final BackButtonWidget _backButtonWidget = BackButtonWidget();

  @override
  Widget build(BuildContext context) {
    final AppProviders _appProviders = Provider.of<AppProviders>(context);
    final DetailPostProviders _detailPostProviders =
        Provider.of<DetailPostProviders>(context);
    final Map<String, dynamic> _object =
        ModalRoute.of(context).settings.arguments;
    final DocumentSnapshot _documentSnapshot = _object['documentSnapshot'];
    final PostModel _postModel = PostModel.fromMap(_documentSnapshot.data);

    _onBackButtonPressed() {
      if (_detailPostProviders.selectedOption == '') {
        Navigator.pop(context);
      } else {
        _alertDialogWidget.createAlertDialogWidget(
          context,
          ContentTexts.leavePage,
          ContentTexts.leaveConfirmation,
          ContentTexts.leave,
          routeName: ContentTexts.homeRoute,
          isOnlyCancelButton: false,
          isVote: true,
          detailPostProviders: _detailPostProviders,
        );
      }
    }

    final IconButton _backButton = _backButtonWidget.createBackButton(
      context,
      ContentTexts.backToHomeRoute,
      () {
        _onBackButtonPressed();
      },
      isVote: true,
    );

    final Hero _postImage = Hero(
      tag: 'postImage${_object['index']}',
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: _postModel.imageUrl,
        progressIndicatorBuilder: (context, url, download) => Center(
          child: CircularProgressIndicator(
            value: download.progress,
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        imageBuilder: (context, imageProvider) => Container(
          height: ContentSizes.height(context),
          width: ContentSizes.width(context),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.transparent,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );

    final Text _postTitle = Text(
      _postModel.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp24(context),
          ),
    );

    final Expanded _postDescription = Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: ContentSizes.width(context) * 0.05,
          right: ContentSizes.width(context) * 0.05,
        ),
        child: Text(
          _postModel.description,
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr,
          style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize: ContentSizes.dp12(context),
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );

    final Expanded _optionsList = Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(
          left: ContentSizes.width(context) * 0.05,
          right: ContentSizes.width(context) * 0.05,
        ),
        itemCount: _postModel.detailVotes.toMap().length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Radio(
              activeColor: ContentColors.orange,
              value: _postModel.detailVotes.toMap().keys.elementAt(index),
              groupValue: _detailPostProviders.selectedOption,
              onChanged: (value) {
                _detailPostProviders.selectedOption = value;
                _detailPostProviders.index = index;
              },
            ),
            title: Text(
              _postModel.detailVotes.toMap().keys.elementAt(index),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
              style: Theme.of(context).textTheme.headline1.copyWith(
                    fontSize: ContentSizes.dp20(context),
                  ),
            ),
          );
        },
      ),
    );

    final Material _voteButtonWidget =
        _actionButtonWidget.createActionButtonWidget(
      context,
      ContentColors.orange,
      ContentColors.white,
      ContentTexts.vote,
      () async {
        if (_detailPostProviders.selectedOption == '') {
          _alertDialogWidget.createAlertDialogWidget(
            context,
            ContentTexts.chooseFirst,
            ContentTexts.chooseDescription,
            ContentTexts.ok,
          );
        } else {
          _alertDialogWidget.createAlertDialogWidget(
            context,
            ContentTexts.confirmVote,
            ContentTexts.confirmVoteDescription,
            ContentTexts.confirm,
            isOnlyCancelButton: false,
            isConfirmVote: true,
            documentSnapshot: _documentSnapshot,
            appProviders: _appProviders,
            detailPostProviders: _detailPostProviders,
          );
        }
      },
    );
    // TODO FIX IMAGE URL
    final CircleAvatar _photoProfile =
        _photoProfileWidget.createPhotoProfileWidget(
      ContentSizes.height(context) * 0.025,
      ContentSizes.height(context) * 0.05,
    );

    final Text _displayName = Text(
      _postModel.displayName,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp12(context),
          ),
    );

    final Text _username = Text(
      '@${_postModel.username}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline2.copyWith(
            fontSize: ContentSizes.dp10(context),
          ),
    );

    final Image _categoryIcon = Image.asset(
      'assets/icons/category_icon.png',
      height: ContentSizes.height(context) * 0.03,
      width: ContentSizes.height(context) * 0.03,
    );

    final Text _category = Text(
      _postModel.category,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp12(context),
          ),
    );

    final Image _voteIcon = Image.asset(
      'assets/icons/vote_icon.png',
      height: ContentSizes.height(context) * 0.03,
      width: ContentSizes.height(context) * 0.03,
    );

    final Text _totalVotes = Text(
      '${_postModel.totalVotes.toString()} voted',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp12(context),
          ),
    );

    final Row _postOwner = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _photoProfile,
        SizedBox(
          width: ContentSizes.width(context) * 0.02,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _displayName,
            _username,
          ],
        ),
      ],
    );

    final Row _categoryInfo = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _categoryIcon,
        SizedBox(
          width: ContentSizes.width(context) * 0.02,
        ),
        _category,
      ],
    );

    final Row _voteInfo = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _voteIcon,
        SizedBox(
          width: ContentSizes.width(context) * 0.02,
        ),
        _totalVotes,
      ],
    );

    final Container _firstLayer = Container(
      height: ContentSizes.height(context),
      width: ContentSizes.width(context),
      color: ContentColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: _postImage,
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                ContentSizes.width(context) * 0.05,
                ContentSizes.height(context) * 0.1,
                ContentSizes.width(context) * 0.05,
                ContentSizes.height(context) * 0.01,
              ),
              color: ContentColors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _postDescription,
                  SizedBox(
                    height: ContentSizes.height(context) * 0.01,
                  ),
                  _optionsList,
                  SizedBox(
                    height: ContentSizes.height(context) * 0.01,
                  ),
                  _voteButtonWidget,
                ],
              ),
            ),
          ),
        ],
      ),
    );

    final Container _secondLayer = Container(
      height: ContentSizes.height(context) * 0.15,
      margin: EdgeInsets.only(
        left: ContentSizes.width(context) * 0.05,
        right: ContentSizes.width(context) * 0.05,
      ),
      padding: EdgeInsets.fromLTRB(
        ContentSizes.width(context) * 0.05,
        ContentSizes.height(context) * 0.015,
        ContentSizes.width(context) * 0.05,
        ContentSizes.height(context) * 0.015,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: ContentColors.black,
            spreadRadius: 0.01,
            blurRadius: 15,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _postTitle,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _postOwner,
              _categoryInfo,
              _voteInfo,
            ],
          ),
        ],
      ),
    );

    return _appProviders.isLoading
        ? WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: Center(
                child: Loading(
                  color: ContentColors.orange,
                  indicator: BallSpinFadeLoaderIndicator(),
                  size: ContentSizes.height(context) * 0.1,
                ),
              ),
            ),
          )
        : WillPopScope(
            onWillPop: () async => _onBackButtonPressed(),
            child: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                leading: _backButton,
                backgroundColor: Colors.transparent,
              ),
              extendBodyBehindAppBar: true,
              body: Stack(
                alignment: Alignment.center,
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  _firstLayer,
                  _secondLayer,
                ],
              ),
            ),
          );
  }
}
