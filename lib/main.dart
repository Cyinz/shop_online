import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:shop_online/pages/index_page.dart';
import 'package:shop_online/provide/child_category.dart';
import 'package:shop_online/provide/category_goods_list.dart';

void main() {
  var providers = Providers();
  var childCategory = ChildCategory();
  var categoryGoodsListProvider = CategoryGoodsListProvider();
  providers
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(
        Provider<CategoryGoodsListProvider>.value(categoryGoodsListProvider));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: '百姓生活+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink,
      ),
      home: IndexPage(),
    );
  }
}
