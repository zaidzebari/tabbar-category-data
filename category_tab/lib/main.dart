import 'dart:convert';
import 'package:category_tab/category_model.dart';
import 'package:category_tab/json_data.dart';
import 'package:category_tab/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // providers:providers,
      //CourseProvider
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ],
      child: StartApp(),
    );
  }
}

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Category:Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Dynamic Category with tab'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool load = false;

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  getCategory() async {
    await Provider.of<CategoryProvider>(context, listen: false).getcategory();
    setState(() {
      load = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<CategoryProvider>(builder: (BuildContext context,
              CategoryProvider categoryProvider, Widget child) {
              return DefaultTabController(
                length: categoryProvider.categoryModel.length,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(widget.title),
                    bottom: TabBar(
                        indicatorColor: Colors.white,
                        isScrollable: true,
                        physics: ScrollPhysics(),
                        onTap: (index) {
                          print('from index');
                        },
                        tabs: [
                          for (int i = 0;
                              i < categoryProvider.categoryModel.length;
                              i++) ...{
                            Tab(
                              text: categoryProvider.categoryModel[i].name,
                            )
                          }
                        ]),
                  ),
                  body: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      for (int i = 0;
                          i < categoryProvider.categoryModel.length;
                          i++)
                        MyController(
                          id: categoryProvider.categoryModel[i].id,
                          i: i,
                        ),
                    ],
                  ),
                ),
              );
            }),
    );
  }
}

class MyController extends StatefulWidget {
  final int id;
  final int i;
  MyController({Key key, this.id, this.i}) : super(key: key);

  @override
  _MyControllerState createState() => _MyControllerState(id, i);
}

class _MyControllerState extends State<MyController>
    with AutomaticKeepAliveClientMixin {
  _MyControllerState(this.id, this.i);
  final int id;
  final int i;

  @override
  void initState() {
    super.initState();
    print('category id $id and index : $i');
    getCategoryData();
  }

  getCategoryData() async {
    await Provider.of<CategoryProvider>(context, listen: false).getData(id, i);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        await getCategoryData();
        return null;
      },
      child: Consumer<CategoryProvider>(builder: (BuildContext context,
          CategoryProvider categoryProvider, Widget child) {
        return categoryProvider.categoryModel[i].data == null
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView.builder(
                itemCount: categoryProvider.categoryModel[i].data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      print('you on tapped to category id : $id');
                    },
                    leading: Text(i.toString()),
                    title: Text(
                        categoryProvider.categoryModel[i].data[index].name),
                    subtitle: Text(categoryProvider
                        .categoryModel[i].data[index].id
                        .toString()),
                  );
                },
              );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
