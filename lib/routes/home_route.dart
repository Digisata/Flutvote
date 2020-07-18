import 'package:flutter/material.dart';
import 'package:flutvote/commons/commons.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/routes/routes.dart';
import 'package:flutvote/widgets/widgets.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  final TextEditingController _textEditingControllerSearch =
      TextEditingController();

  @override
  void initState() {
    HiveProviders.setFirstSignedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppProviders _appProviders = Provider.of<AppProviders>(context);

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

    final PhotoProfileWidget _photoProfileWidget = PhotoProfileWidget(
      ContentSizes.height(context) * 0.025,
      ContentSizes.height(context) * 0.05,
    );

    final GestureDetector _photoProfile = GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/profileRoute');
      },
      child: _photoProfileWidget.createPhotoProfileWidget(),
    );

    final SearchBarWidget _searchBar = SearchBarWidget(
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
      child: CategoryWidget(context).createCategoryWidget(),
    );

    return _appProviders.isLoading
        ? Scaffold(
            body: Loading(
              color: ContentColors.orange,
              indicator: BallSpinFadeLoaderIndicator(),
              size: ContentSizes.height(context) * 0.1,
            ),
          )
        : DefaultTabController(
            length: 2,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                _speakYourVote,
                                _photoProfile,
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
                            child: _searchBar.createSearchBarWidget(),
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
          );
  }
}
