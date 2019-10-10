import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(1080.0),
      height: ScreenUtil().setHeight(120.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {},
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
            onTap: () {},
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
            onTap: () {},
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
