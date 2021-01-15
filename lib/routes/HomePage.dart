import 'package:flutter/material.dart';
import '../widgets/BottomNavWidget.dart';
import 'package:city_pickers/city_pickers.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: GestureDetector(
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
                      });
                    }
                  },
                ),
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
      body: Container(
        child: Text('首页'),
      ),
    );
  }
}
