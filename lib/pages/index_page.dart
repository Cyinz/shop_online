import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_online/pages/cart_page.dart';
import 'package:shop_online/pages/category_page.dart';
import 'package:shop_online/pages/home_page.dart';
import 'package:shop_online/pages/member_page.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IndexState();
  }
}

class IndexState extends State<IndexPage> {
  //当前页面索引，默认为首页
  int _currentIndex = 0;

  //当前页面
  var _currentPage;

  //底部导航栏菜单
  final List<BottomNavigationBarItem> _bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心'),
    ),
  ];

  //底部导航页面
  final List<Widget> _tabBodies = [
    HomePage(), //首页
    CategoryPage(), //分类页
    CartPage(), //购物车页
    MemberPage(), //会员中心页
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //初始化将当前页面设置为首页
    _currentPage = _tabBodies[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    //设置设计稿初始屏幕大小
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1980)..init(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: IndexedStack(
        index: _currentIndex,
        children: _tabBodies,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomTabs,
        //设置底部导航栏类型，否则超过三个item会报错
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
            _currentPage = _tabBodies[_currentIndex];
          });
        },
      ),
    );
  }
}