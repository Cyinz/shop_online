import 'package:flutter/material.dart';
import 'package:shop_online/model/categoryGoodsList.dart';

class CategoryGoodsListProvider with ChangeNotifier{
  List<CategoryListData> goodsList = [];

  //点击左侧大类时，更换商品列表
  getGoodsList(List<CategoryListData> list){
    goodsList = list;
    notifyListeners();
  }

  getMoreList(List<CategoryListData> list){
    goodsList.addAll(list);
    notifyListeners();
  }
}