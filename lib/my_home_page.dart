import 'dart:convert';

import 'package:audio_player/my_tabs.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart' as AppColors;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List? popularBooks, books;
  ScrollController? _scrollController;
  TabController? _tabController;

  readData() async {
    await DefaultAssetBundle.of(context)
        .loadString('json/popularBooks.json')
        .then((value) {
      setState(() {
        popularBooks = jsonDecode(value);
      });
    });

    await DefaultAssetBundle.of(context)
        .loadString('json/books.json')
        .then((value) {
      setState(() {
        books = jsonDecode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.background,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageIcon(
                      AssetImage("img/menu.png"),
                      size: 24,
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.notifications)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Text("Populer Books",
                          style: TextStyle(fontSize: 30))),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -20,
                      right: 0,
                      child: Container(
                        height: 180,
                        child: PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            itemCount:
                                popularBooks == null ? 0 : popularBooks!.length,
                            itemBuilder: (_, i) {
                              return Container(
                                margin: EdgeInsets.only(right: 5, left: 5),
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage(popularBooks![i]["img"]),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll) {
                    return [
                      SliverAppBar(
                        backgroundColor: AppColors.sliverBackground,
                        pinned: true,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(50),
                          child: Container(
                            margin: EdgeInsets.only(left: 20, bottom: 20),
                            child: TabBar(
                              indicatorPadding: EdgeInsets.zero,
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: EdgeInsets.only(right: 8),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 7,
                                      offset: Offset(0, 0),
                                    ),
                                  ]),
                              tabs: [
                                AppTabs(
                                  color: AppColors.menu1Color,
                                  text: "New",
                                ),
                                AppTabs(
                                  color: AppColors.menu2Color,
                                  text: "Populer",
                                ),
                                AppTabs(
                                  color: AppColors.menu3Color,
                                  text: "Trending",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        itemCount: books == null ? 0 : books!.length,
                        itemBuilder: (_, i) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            color: AppColors.tabVarViewColor,
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  books![i]["img"]))),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                size: 24,
                                                color: AppColors.starColor),
                                            SizedBox(width: 5),
                                            Text(
                                              books![i]["rating"],
                                              style: TextStyle(
                                                  color: AppColors.menu2Color),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          books![i]["title"],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Avenir",
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          books![i]["text"],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Avenir",
                                              color: AppColors.subTitleText),
                                        ),
                                        Container(
                                          width: 60,
                                          height: 20,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: AppColors.loveColor,
                                          ),
                                          child: Text(
                                            "Love",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: "Avenir",
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text("Content"),
                        ),
                      ),
                      Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text("Content"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
