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

class HomeState extends State<HomePage> {
  String homePageContent = "正在获取数据";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: FutureBuilder(
        future: getHomePageContent(),
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
      height: ScreenUtil().setHeight(400.0),
      width: ScreenUtil().setWidth(1080.0),
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
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(10.0)),
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
