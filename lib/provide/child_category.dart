import 'package:flutter/material.dart';
import 'package:shop_online/model/category.dart';

class ChildCategory with ChangeNotifier{
  //子类列表
  List<BxMallSubDto> childCategoryList = [];
  //子类索引
  int childIndex = 0;
  //大类ID
  String categoryId = '4';
  //小类ID
  String subId = '';
  //列表页数
  int page = 1;
  //数据全部加载完成后显示
  String noMoreText = '';

  //左侧大类切换调用
  getChildCategory(List<BxMallSubDto> list,String id){
    childIndex = 0;
    categoryId = id;
    page = 1;
    noMoreText = '';
    subId = '';
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index, String id){
    page = 1;
    noMoreText = '';
    childIndex = index;
    subId = id;
    notifyListeners();
  }

  //上拉加载更多
  addPage(){
    page++;
  }

  //改变加载完成后提示信息
  changeNoMore(String text){
    noMoreText = text;
    notifyListeners();
  }
}