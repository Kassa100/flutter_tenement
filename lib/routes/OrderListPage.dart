import 'package:flutter/material.dart';
import '../widgets/BottomNavWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/request.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../common/store.dart' as BaseStore;
import '../widgets/ImageWidget.dart';



class OrderListPage extends StatefulWidget {
  OrderListPage({Key key, this.title});
  final String title;
  final Store store = BaseStore.AppStore;

  @override
  OrderListPageState createState() {
    return OrderListPageState();
  }
}


class OrderListPageState extends State<OrderListPage> {
  List _renderList = [];
  //初始请求数据
  void getInitData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    if(userId == null){
      Navigator.pushReplacementNamed(context, 'loginPage');
    }else{
      var _data = await Request(context).getOrderList(queryParameters: {
        'userId':userId,
      });
      setState(() {
        _renderList.addAll(_data.list);
      });
    }
  }
  //页面进入执行
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavWidget(
        select: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _renderList.map((i){
            return _renderList.length != 0? GestureDetector(
              onTap: (){
                widget.store.dispatch(BaseStore.ProjectDetailAction(payload: i));
                Navigator.pushNamed(context, 'projectDetail');
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    ImageWidget(
                      url: i['ppt_file_url'],
                      w:150.0,
                      h: 120.0,
                    ),
                    Container(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Wrap(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //  名称
                              Text(
                                i['ppt_name'].length<=10?i['ppt_name']:i['ppt_name'].substring(0,10)+'...',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              //  地区
                              Text(
                                i['region_name']+i['ar_name'],
                                style: TextStyle(
                                  fontSize: 14.0,
                                  height: 2.0,
                                ),
                              ),
                              //  特色
                              Row(
                                children: i['detail']['label_group'].map<Widget>((i){
                                  return Container(
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
                                      child: Text(
                                        i,
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          background: new Paint()..color = Colors.blue[50],
                                          height: 2.0,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              //  房租
                              Flex(
                                mainAxisSize: MainAxisSize.max,
                                direction: Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    i['detail']['price']+'/月',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.red[300],
                                      height: 2.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ):Center(
              child: Text('暂无数据'),
            );
          }).toList(),
        ),
      ),
    );
  }
}
