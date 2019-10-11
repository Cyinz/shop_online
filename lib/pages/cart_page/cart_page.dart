import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:shop_online/pages/cart_page/cart_bottom.dart';
import 'package:shop_online/pages/cart_page/cart_item.dart';
import 'package:shop_online/provide/cart.dart';

//购物车页
class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CartState();
  }
}

class CartState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List cartList = Provide.value<CartProvide>(context).cartList;
            return Stack(
              children: <Widget>[
                Provide<CartProvide>(
                  builder: (context, child, childCategory){
                    cartList = Provide.value<CartProvide>(context).cartList;
                    print("cartList = :${cartList}");
                    return ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return CartItem(cartList[index]);
                      },
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottom(),
                ),
              ],
            );
          } else {
            return Text('正在加载');
          }
        },
      ),
    );
  }

  //获取商品信息
  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}
