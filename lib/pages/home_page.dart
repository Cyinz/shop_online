import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shop_online/service_method.dart';
import 'package:url_launcher/url_launcher.dart';

//首页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  String homePageContent = "正在获取数据";

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var formData = {'lon': '115.02932', 'lat': '35.76189'};

    return Scaffold(
      body: FutureBuilder(
        future: request('homePageContent', formData),
        //getHomePageContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //数据处理
            var data = json.decode(snapshot.data.toString());
            //顶部轮播组件列表数据
            List<Map> _swiperDataList = (data['data']['slides'] as List).cast();
            //导航菜单数据
            List<Map> _navigatorList =
                (data['data']['category'] as List).cast();
            //广告图片数据
            String _adPicture =
                data['data']['advertesPicture']['PICTURE_ADDRESS'];
            //店长数据
            String _leaderImage = data['data']['shopInfo']['leaderImage'];
            String _leaderPhone = data['data']['shopInfo']['leaderPhone'];
            //推荐商品数据
            List<Map> _recommentList =
                (data['data']['recommend'] as List).cast();
            //楼层1数据
            String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            List<Map> floor1 = (data['data']['floor1'] as List).cast();
            //楼层2数据
            String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
            List<Map> floor2 = (data['data']['floor2'] as List).cast();
            //楼层3数据
            String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floor3 = (data['data']['floor3'] as List).cast();

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SwiperDiy(
                    swiperDataList: _swiperDataList,
                  ),
                  TopNavigator(
                    navigatorList: _navigatorList,
                  ),
                  AdNanner(
                    adPicture: _adPicture,
                  ),
                  LeaderPhone(
                    leaderImage: _leaderImage,
                    leaderPhone: _leaderPhone,
                  ),
                  Recommend(
                    recommendList: _recommentList,
                  ),
                  FloorTitle(picture_address: floor1Title,),
                  FloorContent(floorGoodsList: floor1,),
                  FloorTitle(picture_address: floor2Title,),
                  FloorContent(floorGoodsList: floor2,),
                  FloorTitle(picture_address: floor3Title,),
                  FloorContent(floorGoodsList: floor3,),
                  HotGoods(),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('加载中'),
            );
          }
        },
      ),
    );
  }
}

//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 200,
      child: Swiper(
        itemCount: swiperDataList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            '${swiperDataList[index]['image']}',
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//顶部导航
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  //导航子组件
  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            height: 60,
          ),
          Text(
            item['mallCategoryName'],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    //分类导航只取10个
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }

    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 190,
      child: GridView.count(
        childAspectRatio: 0.9,
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

//中间广告
class AdNanner extends StatelessWidget {
  final String adPicture;

  AdNanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//拨打店长电话模块
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: InkWell(
        onTap: () {
          _launchURL();
        },
        child: Image.network(leaderImage),
      ),
    );
  }

  //拨打店长电话
  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

//商品推荐模块
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  //推荐商品标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.grey,
          ),
        ),
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  //商品项
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 140,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.2),
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('¥${recommendList[index]['mallPrice']}'),
            Text(
              '¥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //推荐商品列表
  Widget _recommedList() {
    return Container(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommedList(),
        ],
      ),
    );
  }
}

//楼层标题
class FloorTitle extends StatelessWidget {
  final String picture_address;

  FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address),
    );
  }
}

//楼层商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods(),
        ],
      ),
    );
  }

  //商品列表第一行
  Widget _firstRow(){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  //商品列表第二行
  Widget _otherGoods(){
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4]),
      ],
    );
  }

  //商品子项
  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(540.0),
      child: InkWell(
        child: Image.network(goods['image']),
        onTap: () {
          print('点击了楼层商品');
        },
      ),
    );
  }
}

//
class HotGoods extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HotGoodsState();
  }
}

class _HotGoodsState extends State<HotGoods> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    request('homePageBelowContent', 1).then((value){
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('haha'),
    );
  }
}
