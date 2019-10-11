import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_online/model/cartInfo.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  //商品列表
  List<CartInfoModel> cartList = [];
  //总价格
  double allPrice = 0;
  //商品总数量
  int allGoodsCount = 0;
  //是否全选
  bool isAllCheck = true;

  //添加到购物车
  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //得到持久化的数据
    cartString = sharedPreferences.getString('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    //是否已加入购物车
    bool isHave = false;
    //索引
    int ival = 0;
    //循环判断购物车中是否已有此商品
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;
        isHave = true;
      }
      ival++;
    });
    //如果购物车中没有，加入购物车
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true,
      };
      tempList.add(newGoods);
      cartList.add(new CartInfoModel.fromJson(newGoods));
    }

    cartString = json.encode(tempList).toString();
    sharedPreferences.setString('cartInfo', cartString);
    notifyListeners();
  }

  //清空购物车
  remove() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('cartInfo');
    cartList = [];
    notifyListeners();
  }

  //得到购物车数据
  getCartInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString('cartInfo');
    cartList = [];
    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;
      tempList.forEach((item) {
        if(item['isCheck']){
          allPrice += (item['count'] * item['price']);
          allGoodsCount += item['count'];
        }
        else{
          isAllCheck = false;
        }
        cartList.add(CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }

  //删除购物车单个商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == goodsId){
        delIndex= tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    sharedPreferences.setString('cartInfo', cartString);
    await getCartInfo();
  }

  //勾选单个商品
  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == cartItem.goodsId){
        changeIndex= tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    sharedPreferences.setString('cartInfo', cartString);
    await getCartInfo();
  }

  //改变全选状态
  changeAllCheckButtonState(bool isCheck) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    //循环时不允许更改值，新建列表保存更改数据
    List<Map> newList = [];
    for(var item in tempList){
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }
    cartString = json.encode(newList).toString();
    sharedPreferences.setString('cartInfo', cartString);
    await getCartInfo();
  }

  //商品数量加减
  addOrReduceAction(CartInfoModel cartItem, String todo) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == cartItem.goodsId){
        changeIndex= tempIndex;
      }
      tempIndex++;
    });
    if(todo == 'add'){
      cartItem.count++;
    }
    else if(todo == 'reduce' && cartItem.count > 1){
      cartItem.count--;
    }
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    sharedPreferences.setString('cartInfo', cartString);
    await getCartInfo();
  }
}
