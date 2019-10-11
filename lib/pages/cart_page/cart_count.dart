import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:shop_online/model/cartInfo.dart';
import 'package:shop_online/provide/cart.dart';

class CartCount extends StatelessWidget {
  CartInfoModel item;
  CartCount(this.item);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(200.0),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.black12,
        ),
      ),
      child: Row(
        children: <Widget>[
          _reduceButton(context),
          _countArea(),
          _addButton(context),
        ],
      ),
    );
  }

  //减少按钮
  Widget _reduceButton(context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvider>(context).addOrReduceAction(item, 'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(50.0),
        height: ScreenUtil().setHeight(50.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: item.count > 1 ? Colors.white : Colors.black12,
          border: Border(
            right: BorderSide(
              width: 1.0,
              color: Colors.black12,
            ),
          ),
        ),
        child: item.count > 1 ? Text('-') : Text(' '),
      ),
    );
  }

  //增加按钮
  Widget _addButton(context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvider>(context).addOrReduceAction(item, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(50.0),
        height: ScreenUtil().setHeight(50.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              width: 1.0,
              color: Colors.black12,
            ),
          ),
        ),
        child: Text('+'),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea(){
    return Container(
      width: ScreenUtil().setWidth(90.0),
      height: ScreenUtil().setHeight(50.0),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
  }
}
