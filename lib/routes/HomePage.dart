import 'package:flutter/material.dart';
import '../widgets/BottomNavWidget.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../common/store.dart' as BaseStore;
import '../models/home.dart';
import '../service/request.dart';
import '../common/loading.dart';

class City {
  City(this.cityId, this.cityName);
  final String cityId;
  final String cityName;
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title});
  final String title;
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  City city;
  Home data = null; //数据变量
  void _getData(context) async {
    // 结合service做数据请求
    print('请求+1');
    Home _data = await Request(context).getHome();
    print(_data);
    setState(() {
      data = _data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      // 初次数据请求
      print('首次请求');
      _getData((context));
    }
    // store 初始化配置
    return new StoreProvider(
      store: BaseStore.AppStore,
      child: Scaffold(
        // 首页标题书写
        appBar: AppBar(
          title: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: 50.0,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 5,
                  child: new StoreConnector(builder: (context, calback) {
                    return GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            city != null ? city.cityName : '深圳市',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      onTap: () async {
                        print('选中城市');
                        // 城市选中实例化
                        Result result = await CityPickers.showCityPicker(
                          context: context,
                          showType: ShowType.pc,
                          cancelWidget: Text(
                            '取消',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          confirmWidget: Text(
                            '确定',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          height: 260,
                        );
                        if (result != null) {
                          setState(() {
                            city = City(result.cityId, result.cityName);
                            calback();
                          });
                        }
                      },
                    );
                  }, converter: (store) {
                    return () => store.dispatch(
                        BaseStore.LocationAction(payload: city.cityName));
                  }),
                ),
                Container(
                  child: Center(
                    child: Transform.translate(
                      offset: Offset(25, 0),
                      child: Text(widget.title),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('点击查询');
              },
            )
          ],
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavWidget(
          select: 0,
        ),
        body: data != null
            ? SingleChildScrollView(
                child: Container(
                  color: Colors.grey[200],
                  child: Column(
                    // 整体的垂直布局
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: data.banner != null
                                ? NetworkImage(data.banner)
                                : AssetImage('assets/images/01.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                            width: double.infinity,
                            height: 180.0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // 模拟模态框
                                Container(
                                  margin: EdgeInsets.only(top: 20.0),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(180, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      width: 300.0,
                                      height: 25.0,
                                      padding: EdgeInsets.only(top: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Icon(
                                        Icons.search,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                // 中间描述文字
                                Container(
                                  margin: EdgeInsets.only(top: 25),
                                  child: Center(
                                    child: Text(
                                      '品牌公寓直租房源',
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              )
            : Loading(
                color: Colors.white,
                opacity: 0.9,
              ),
      ),
    );
  }
}
