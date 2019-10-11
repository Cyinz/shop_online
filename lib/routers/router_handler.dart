import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:shop_online/pages/details_page/details_page.dart';

Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    //商品ID
    String goodsId = params['id'].first;
    return DetailsPage(goodsId);
  }
);