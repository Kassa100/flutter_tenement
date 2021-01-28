import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../common/store.dart' as BaseStore;
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:toast/toast.dart';
import '../widgets/ImageWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/request.dart';

class ProjectDetail extends StatefulWidget{
  ProjectDetail({Key key,this.title,});
  final String title;
  final Store store = BaseStore.AppStore;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProjectDetail();
  }
}

class _ProjectDetail extends State<ProjectDetail>{
  Map data = null;
  //配套设施Icon
  Map keys = {
    '床':Icons.store,
    '厨房':Icons.kitchen,
    '热水器':Icons.healing,
    '空调':Icons.archive,
    '网络':Icons.wifi,
    '电视':Icons.tv,
    '冰箱':Icons.room_service,
    '洗衣机':Icons.local_drink,
    '衣柜':Icons.account_box,
    '电梯':Icons.edit_location,
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.store.state.projectDetail;
    print(data);
  }
  //收藏功能
  _collection(context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    //用户信息不存在，进行路由跳转
    if(userId == null){
      Navigator.pushNamed(context, 'loginPage');
    }else{
      var _data = await Request(context).sendCollection(queryParameters: {
        'userId':userId,
        'projectId':data['ppt_files_id'],
      });
      if(_data.msg == 'ok'){
        Toast.show('收藏成功', context,duration: Toast.LENGTH_LONG,gravity: Toast.CENTER);
      }else{
        Toast.show(_data.msg, context,duration: Toast.LENGTH_LONG,gravity: Toast.CENTER);
      }
    }
  }
  //预约看房
  _order(context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    //用户信息不存在，进行路由跳转
    if(userId == null){
      Navigator.pushNamed(context, 'loginPage');
    }else{
      var _data = await Request(context).sendOrder(queryParameters: {
        'userId':userId,
        'projectId':data['ppt_files_id'],
      });
      if(_data.msg == 'ok'){
        Toast.show('预约成功', context,duration: Toast.LENGTH_LONG,gravity: Toast.CENTER);
      }else{
        Toast.show(_data.msg, context,duration: Toast.LENGTH_LONG,gravity: Toast.CENTER);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreProvider(
      store: widget.store,
      child: Scaffold(
        appBar: AppBar(
          title:Text(widget.title),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  //轮播图
                  BannerSwiper(
                    //宽度和高度的比例，并不是真实的像素
                    width: 75,
                    height: 100,
                    spaceMode: false,
                    length: data!= null?data['detail']['banner'].length:0,//轮播数目
                    getwidget: (index){ //轮播渲染
                      if(data == null){
                        return Text('');
                      }
                      List _list = data['detail']['banner'];
                      return new GestureDetector(
                        onTap: (){

                        },
                        child: ImageWidget(
                          url:_list[index%_list.length]['maxImage'],
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  ),
                  //参数信息模块
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        //  左侧信息
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                //名称
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  data['ppt_name'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            //  价格和格局
                              Row(
                                children: [
                                  Text(
                                    data['detail']['type'],
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  Text(
                                    data['detail']['price'],
                                    style:TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.red[400],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //右侧信息
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: data['detail']['label_group'].map<Widget>((i){
                              return Container(
                                margin: EdgeInsets.only(left: 5.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue[400],
                                    width: 1.0,
                                  ),
                                ),
                                padding: EdgeInsets.all(3.0),
                                child: Text(
                                  i,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.blue[400],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: .1,
                    color: Colors.grey[800],
                  ),
                  //详细信息
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Wrap(
                      children: data['detail']['info_detail'].map<Widget>((i){
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.0),
                          width: MediaQuery.of(context).size.width / 2,
                          child: Row(
                            children: [
                              Text(
                                i.first,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 10.0,),),
                              Text(
                                i.last,
                                style: TextStyle(
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    height: 10.0,
                    color: Colors.grey[200],
                  ),
                  //  位置信息
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            '位置及周边',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            data['region_name']+'-'+data['ar_name'],
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child:Text(
                            data['subway_info'],
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //  房源描述
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            '房源描述',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 3.0, 0.0, 0.0),
                          child: Text(
                            data['detail']['description_box'],
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 10.0,
                    color: Colors.grey[200],
                  ),
                  // 配套设施
                  Container(
                    // width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                          child: Text(
                            '配套设施',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Wrap(
                          spacing: 20.0,
                          runSpacing: 4.0,
                          alignment: WrapAlignment.center,
                          children: data['detail']['facilities_box'].map<Widget>((i){
                            double w = MediaQuery.of(context).size.width / 7;
                            if(i['is_state']){
                              return Column(
                                children: [
                                  Container(
                                    width: w,
                                    height: w,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey[400],
                                      ),
                                      borderRadius: BorderRadius.circular(w),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        keys[i['title']],
                                        size: w/1.5,
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                                  Text(
                                    i['title'],
                                  ),
                                ],
                              );
                            }else{
                              return Container(width: 0,height: 0,);
                            }
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 10.0,
                    color: Colors.grey[200],
                  ),
                  // 猜你喜欢
                  Container(
                    // width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                          child: Text(
                            '猜你喜欢',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(bottom: 50.0,),
                          child: Row(
                            children: data['detail']['recommended_box'].map<Widget>((i){
                              return Container(
                                width: 260.0,
                                margin: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    ImageWidget(
                                      url: i['maxImage'],
                                      w: 260.0,
                                      h: 150.0,
                                      fit: BoxFit.fill,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5.0),
                                      child: Row(
                                        children: [
                                          Text(i['title']),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          i['addr'],
                                          style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        Text(
                                          i['price'],
                                          style: TextStyle(
                                            color: Colors.orange[900],
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //底部按钮
            Positioned(
              bottom: 0.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlineButton(
                        child: Text('收藏'),
                        onPressed: (){
                          _collection(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                    ),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        color: Colors.red,
                        child: Text(
                          '预约看房',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: (){
                          _order(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}