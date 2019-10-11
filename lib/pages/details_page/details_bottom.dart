import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shop_online/provide/cart.dart';
import 'package:shop_online/provide/details_info.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var images = goodsInfo.image1;

    return Container(
      width: ScreenUtil().setWidth(1080.0),
      height: ScreenUtil().setHeight(120.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () async {

            },
            child: Container(
              width: ScreenUtil().setWidth(150.0),
              alignment: Alignment.center,
              child: Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.red,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context).save(goodsId, goodsName, count, price, images);
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(465.0),
              height: ScreenUtil().setHeight(120.0),
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(36.0),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context).remove();
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(465.0),
              height: ScreenUtil().setHeight(120.0),
              color: Colors.red,
              child: Text(
                '马上购买',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(36.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
