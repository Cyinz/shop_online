import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shop_online/model/details.dart';
import 'package:shop_online/service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier{
  DetailsModel goodsInfo = null;

  //从后台获取商品数据
  getGoodsInfo(String id){
    var formData = {'goodId':id};
    request('getGoodDetailById', formData: formData).then((val){
      var responseData = json.decode(val.toString());
      print(responseData);
      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }
}