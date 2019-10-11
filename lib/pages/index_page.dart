import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shop_online/pages/cart_page/cart_page.dart';
import 'package:shop_online/pages/category_page.dart';
import 'package:shop_online/pages/home_page.dart';
import 'package:shop_online/pages/member_page.dart';
import 'package:shop_online/provide/current_index.dart';

class IndexPage extends StatelessWidget {
  //底部按钮栏
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
  ];

  //对应页面
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1980)..init(context);

    return Provide<CurrentIndexProvider>(
      builder: (context, child, val) {
        int currentIndex =
            Provide.value<CurrentIndexProvider>(context).currentIndex;

        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          body: IndexedStack(
            index: currentIndex,
            children: tabBodies,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            items: bottomTabs,
            onTap: (index) {
              Provide.value<CurrentIndexProvider>(context).changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
