import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//会员中心页
class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(),
          _orderTitle(),
          _orderType(),
          _actionList(),
        ],
      ),
    );
  }

  //顶部头像
  Widget _topHeader() {
    return Container(
      width: ScreenUtil().setWidth(1080.0),
      height: ScreenUtil().setHeight(400.0),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: ClipOval(
              child: Image.asset(
                'images/header_pic.png',
                width: ScreenUtil().setWidth(250.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              'C-yin哲',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36.0),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //我的订单标题
  Widget _orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.black12,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  //订单列表区域
  Widget _orderType() {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      width: ScreenUtil().setWidth(1080.0),
      height: ScreenUtil().setHeight(150.0),
      padding: EdgeInsets.only(top: 10.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(270.0),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.party_mode,
                  size: 30,
                ),
                Text('待付款'),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(270.0),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.query_builder,
                  size: 30,
                ),
                Text('待发货'),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(270.0),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                  size: 30,
                ),
                Text('待收货'),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(270.0),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.content_paste,
                  size: 30,
                ),
                Text('待评价'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //通用ListTile
  Widget _myListTile(String title){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.black12,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  //
  Widget _actionList(){
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _myListTile('领取优惠券'),
          _myListTile('已领取优惠券'),
          _myListTile('地址管理'),
          _myListTile('客服电话'),
          _myListTile('关于我们'),
        ],
      ),
    );
  }
}