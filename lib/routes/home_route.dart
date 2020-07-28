import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/routes/routes.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatelessWidget {
  final TextEditingController _textEditingControllerSearch =
      TextEditingController();
  final AlertDialogWidget _alertDialogWidget = AlertDialogWidget();
  final PostItemWidget _postItemWidget = PostItemWidget();
  final PhotoProfileWidget _photoProfileWidget = PhotoProfileWidget();
  final SearchBarWidget _searchBarWidget = SearchBarWidget();
  final Stream<QuerySnapshot> _postSnapshots =
      Firestore.instance.collection('posts').snapshots();

  @override
  Widget build(BuildContext context) {
    final AppProviders _appProviders = Provider.of<AppProviders>(context);

    _exitApp() {
      _alertDialogWidget.createAlertDialogWidget(
        context,
        ContentTexts.exitApp,
        ContentTexts.exitAppConfirmation,
        ContentTexts.exit,
        isOnlyCancelButton: false,
        isExit: true,
      );
    }

    final Text _speakYourVote = Text(
      ContentTexts.speakYourVote,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
      style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: ContentSizes.dp24(context),
          ),
    );

    final Hero _photoProfile = Hero(
      tag: 'photoProfile',
      child: _photoProfileWidget.createPhotoProfileWidget(
        ContentSizes.height(context) * 0.025,
        ContentSizes.height(context) * 0.05,
      ),
    );

    final Container _searchBar = _searchBarWidget.createSearchBarWidget(
      context,
      _textEditingControllerSearch,
    );

    final Row _categoriesText = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          ContentTexts.categories,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr,
          style: Theme.of(context).textTheme.headline1.copyWith(
                fontSize: ContentSizes.dp24(context),
              ),
        ),
      ],
    );

    final Container _categories = Container(
      height: ContentSizes.height(context) * 0.05,
      width: ContentSizes.width(context),
      child: CategoryWidget().createCategoryWidget(context),
    );

    final StreamBuilder _postList = StreamBuilder<QuerySnapshot>(
      stream: _postSnapshots,
      builder: (context, snapshots) {
        if (!snapshots.hasData) {
          return Expanded(
            child: Loading(
              color: ContentColors.orange,
              indicator: BallPulseIndicator(),
              size: ContentSizes.height(context) * 0.1,
            ),
          );
        } else if (snapshots.hasError) {
          return _alertDialogWidget.createAlertDialogWidget(
            context,
            ContentTexts.oops,
            ContentTexts.errorRetrieveData,
            ContentTexts.ok,
          );
        } else {
          return Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                ContentSizes.width(context) * 0.05,
                ContentSizes.height(context) * 0.05,
                ContentSizes.width(context) * 0.05,
                0,
              ),
              children: snapshots.data.documents
                  .map(
                    (documentSnapshot) =>
                        _postItemWidget.createPostItemWidget(context, documentSnapshot),
                  )
                  .toList(),
            ),
          );
        }
      },
    );

    return _appProviders.isLoading
        ? WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: Loading(
                color: ContentColors.orange,
                indicator: BallSpinFadeLoaderIndicator(),
                size: ContentSizes.height(context) * 0.1,
              ),
            ),
          )
        : DefaultTabController(
            length: 2,
            child: WillPopScope(
              onWillPop: () async => _exitApp(),
              child: Scaffold(
                body: Center(
                  child: TabBarView(
                    children: [
                      SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                ContentSizes.width(context) * 0.05,
                                ContentSizes.height(context) * 0.05,
                                ContentSizes.width(context) * 0.05,
                                0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  _speakYourVote,
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, ContentTexts.settingRoute);
                                    },
                                    child: _photoProfile,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: ContentSizes.height(context) * 0.03,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                ContentSizes.width(context) * 0.05,
                                0,
                                ContentSizes.width(context) * 0.05,
                                0,
                              ),
                              child: _searchBar,
                            ),
                            SizedBox(
                              height: ContentSizes.height(context) * 0.03,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                ContentSizes.width(context) * 0.05,
                                0,
                                ContentSizes.width(context) * 0.05,
                                0,
                              ),
                              child: _categoriesText,
                            ),
                            SizedBox(
                              height: ContentSizes.height(context) * 0.01,
                            ),
                            _categories,
                            SizedBox(
                              height: ContentSizes.height(context) * 0.01,
                            ),
                            _postList,
                          ],
                        ),
                      ),
                      HistoryRoute(),
                    ],
                  ),
                ),
                bottomNavigationBar: TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(Icons.home),
                    ),
                    Tab(
                      icon: Icon(Icons.history),
                    ),
                  ],
                  labelColor: ContentColors.orange,
                  unselectedLabelColor: ContentColors.backgroundDarkGrey,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.all(5.0),
                  indicatorColor: ContentColors.orange,
                  indicatorWeight: 3,
                ),
                floatingActionButton: FloatingActionButton(
                  foregroundColor: ContentColors.orange,
                  backgroundColor: ContentColors.orange,
                  child: Icon(
                    Icons.add,
                    color: ContentColors.white,
                  ),
                  elevation: 3.0,
                  tooltip: ContentTexts.createPost,
                  onPressed: () {},
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
              ),
            ),
          );
  }
}
