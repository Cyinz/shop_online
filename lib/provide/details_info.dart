import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shop_online/model/details.dart';
import 'package:shop_online/service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;

  //设置左边详情和右边评论是否被点击
  bool isLeft = true;
  bool isRight = false;

  //tabbar的切换方法
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }

  //从后台获取商品数据
  getGoodsInfo(String id) async {
    var formData = {'goodId': id};
    await request('getGoodDetailById', formData: formData).then((val) {
      var responseData = json.decode(val.toString());
      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }
}
