import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:shop_online/provide/details_info.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {
          Navigator.pop(context);
        }),
        title: Text('商品详情'),
      ),
      body: FutureBuilder(
          future: _getBackInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Text(goodsId),
                  ],
                ),
              );
            }
            else {
              return Text('加载中......');
            }
          }),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '完成加载';
  }
}