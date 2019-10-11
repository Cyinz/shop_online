import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';
import 'package:shop_online/model/category.dart';
import 'package:shop_online/provide/child_category.dart';
import 'package:shop_online/service/service_method.dart';
import 'dart:convert';
import 'package:shop_online/model/categoryGoodsList.dart';
import 'package:shop_online/provide/category_goods_list.dart';

//分类页
class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CategoryState();
  }
}

class _CategoryState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LeftCategoryNavState();
  }
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  //左侧大类列表
  List list = [];

  //左侧大类索引
  var listIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _getCategory();
    _getGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(240.0),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  //左侧大类子组件
  Widget _leftInkWell(int index) {
    //是否被点击
    bool isChick = false;
    isChick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;

        Provide.value<ChildCategoryProvider>(context)
            .getChildCategory(childList, categoryId);
        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(130.0),
        padding: EdgeInsets.only(left: 10.0, top: 20.0),
        decoration: BoxDecoration(
          color: isChick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12),
          ),
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(36),
            color: isChick ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  //获取大类信息
  void _getCategory() async {
    await request('getCategory').then((val) {
      var _data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(_data);
      setState(() {
        list = category.data;
      });
      Provide.value<ChildCategoryProvider>(context)
          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

  //获取商品分类列表
  void _getGoodsList({String categoryId}) async {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': '',
      'page': 1
    };

    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvider>(context)
          .getGoodsList(goodsList.data);
    });
  }
}

//右侧小类类别
class RightCategoryNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RightCategoryNavState();
  }
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<ChildCategoryProvider>(
        builder: (context, child, childCategory) {
          return Container(
            height: ScreenUtil().setHeight(110.0),
            width: ScreenUtil().setWidth(840.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.black12,
                ),
              ),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context, index) {
                return _rightInkWell(
                    index, childCategory.childCategoryList[index]);
              },
            ),
          );
        },
      ),
    );
  }

  //右侧顶部分类子组件
  Widget _rightInkWell(int index, BxMallSubDto item) {
    //是否已点击
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategoryProvider>(context).childIndex)
        ? true
        : false;

    return InkWell(
      onTap: () {
        Provide.value<ChildCategoryProvider>(context)
            .changeChildIndex(index, item.mallSubId);
        _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(36.0),
            color: isClick ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  //获取商品分类列表
  void _getGoodsList(String categorySubId) async {
    var data = {
      'categoryId': Provide.value<ChildCategoryProvider>(context).categoryId,
      'categorySubId': categorySubId,
      'page': 1
    };

    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provide.value<CategoryGoodsListProvider>(context).getGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvider>(context)
            .getGoodsList(goodsList.data);
      }
    });
  }
}

//商品列表
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  GlobalKey<ClassicalFooterWidgetState> _footerKey =
      new GlobalKey<ClassicalFooterWidgetState>();
  var scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvider>(
      builder: (context, child, data) {
        try {
          if (Provide.value<ChildCategoryProvider>(context).page == 1) {
            //将列表位置重置
            scrollController.jumpTo(0.0);
          }
        } catch (e) {
          print('进入页面第一次初始化;${e}');
        }
        if (data.goodsList.length > 0) {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(840.0),
              child: EasyRefresh(
                footer: ClassicalFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  infoColor: Colors.pink,
                  showInfo: true,
                  noMoreText: Provide.value<ChildCategoryProvider>(context).noMoreText,
                  infoText: '加载中',
                  loadReadyText: '上拉加载',
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: data.goodsList.length,
                  itemBuilder: (context, index) {
                    return _listItemWidget(data.goodsList, index);
                  },
                ),
                onLoad: () async {
                  _getMoreList();
                },
              ),
            ),
          );
        } else {
          return Text('暂时无数据');
        }
      },
    );
  }

  void _getMoreList() {
    Provide.value<ChildCategoryProvider>(context).addPage();

    var data = {
      'categoryId': Provide.value<ChildCategoryProvider>(context).categoryId,
      'categorySubId': Provide.value<ChildCategoryProvider>(context).subId,
      'page': Provide.value<ChildCategoryProvider>(context).page,
    };

    request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Fluttertoast.showToast(
          msg: '已经到底了',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Provide.value<ChildCategoryProvider>(context).changeNoMore('没有更多了');
      } else {
        Provide.value<CategoryGoodsListProvider>(context)
            .getMoreList(goodsList.data);
      }
    });
  }

  //商品子组件
  Widget _listItemWidget(List newList, int index) {
    return InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.black12),
            ),
          ),
          child: Row(
            children: <Widget>[
              _goodsImage(newList, index),
              Column(
                children: <Widget>[
                  _goodsName(newList, index),
                  _goodsPrice(newList, index)
                ],
              )
            ],
          ),
        ));
  }

  //商品图片
  Widget _goodsImage(List newList, int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  //商品名称
  Widget _goodsName(List newList, int index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(640.0),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(36)),
      ),
    );
  }

  //商品价格
  Widget _goodsPrice(List newList, int index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.only(left: 5.0),
      width: ScreenUtil().setWidth(640),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            '价格:￥${newList[index].presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(36),
            ),
          ),
          Text(
            '￥${newList[index].oriPrice}',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
