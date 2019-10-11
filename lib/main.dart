import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:shop_online/pages/index_page.dart';
import 'package:shop_online/provide/cart.dart';
import 'package:shop_online/provide/child_category.dart';
import 'package:shop_online/provide/category_goods_list.dart';
import 'package:shop_online/provide/details_info.dart';
import 'routers/routers.dart';
import 'routers/application.dart';

void main() {
  var providers = Providers();
  var childCategory = ChildCategory();
  var categoryGoodsListProvider = CategoryGoodsListProvider();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();
  providers
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(
        Provider<CategoryGoodsListProvider>.value(categoryGoodsListProvider))
  ..provide(
      Provider<DetailsInfoProvide>.value(detailsInfoProvide))
  ..provide(Provider<CartProvide>.value(cartProvide));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final router = Router();
    Routers.configureRoutes(router);
    Application.router = router;

    return MaterialApp(
      title: '百姓生活+',
      onGenerateRoute: Application.router.generator,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink,
      ),
      home: IndexPage(),
    );
  }
}
