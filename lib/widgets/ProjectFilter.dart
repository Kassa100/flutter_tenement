import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../service/request.dart';

class FilterModel extends StatefulWidget {
  FilterModel({
    Key key,
    this.locationAddr,
    this.modelState,
    this.changeFilter,
    this.retrieveDataFilter,
    this.sendParams,
    this.changeSendParams,
});
  final String locationAddr;
  final Function retrieveDataFilter;
  final Function changeSendParams;
  final Function changeFilter;
  final int modelState;
  final Map sendParams;
  @override
  _FilterModelState createState() => _FilterModelState();
}

class _FilterModelState extends State<FilterModel> {


  //区域相关
  List region_name_list = []; //区级数据列表
  List area_name_list = []; //街道相关数据列表
  String cur_region = '全部';
  String cur_area = '全部';

  //价格相关
  List <String> selects = ['0-1000','1000-3000','3000-5000','5000-10000','>10000'];
  String price = '';

  //房型相关
  List <String> roomList = ['不限','一居','二居','三居','四居','五居'];
  String room = '';

  //特色相关
  List<String> specialList = ['公寓直租','无中介费'];
  List special = [];

  //是否是首次请求
  bool firstRequest = true;

  //获取地区数据函数
  void _getInitData(context) async {
    var _region = await Request(context).getRegionList();
    setState(() {
      List _region_name_list = new List();
      _region_name_list.addAll(_region.data);
      // 遍历所有省级
      _region_name_list.retainWhere((element){
        List _item = element['children']; //市级数据
        int _index = _item.indexWhere((i){
          //遍历所有市级数据
         return i['name'].contains(widget.locationAddr);
        });
        if(_index >= 0){
          region_name_list = _item[_index]['children'];
        }
        return _index >=0;
      });
    });
  }
  // 筛选市区街道数据
  void getAreaList(region){
    region_name_list.every((element) {
      if(element['name'] == region){
        area_name_list = element['children'];
        return false;
      }
      return true;
    });
  }

  @override
  void didUpdateWidget(covariant FilterModel oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {
      cur_region = widget.sendParams['cur_region'];
      cur_area = widget.sendParams['cur_area'];
      price = widget.sendParams['price'];
      room = widget.sendParams['room'];
      special = widget.sendParams['special'];
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget Render = Container(
      width: 0,
      height: 0,
    );
    if(firstRequest){
      _getInitData(context);
      setState(() {
        firstRequest = false;
      });
    }
    switch(widget.modelState) {
      case 1:
        Render = Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
          ),
          padding: EdgeInsets.all(10.0),
          height: 300.0,
          child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //区级数据渲染
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: region_name_list.map((i){
                      return GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            border: cur_region == i['name']?Border(
                              left: BorderSide(
                                color: Colors.blue,
                                width: 1.0
                              ),
                            ):null,
                          ),
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Text(
                              i['name'],
                              style: TextStyle(
                                color:  cur_region == i['name']?Colors.blue:null,
                              ),
                            ),
                          ),
                        ),
                        onTap: (){
                          widget.changeSendParams(
                            params:{
                              'type':'cur_region',
                              'val':i['name'],
                            }
                          );
                          setState(() {
                            getAreaList(i['name']);
                          });
                        },
                      );
                    }).toList()..insert(0,
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              border: cur_region == '全部'?Border(
                                left: BorderSide(
                                    color: Colors.blue,
                                    width: 1.0
                                ),
                              ):null,
                            ),
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: Text(
                                '全部',
                                style: TextStyle(
                                  color:  cur_region == '全部'?Colors.blue:null,
                                ),
                              ),
                            ),
                          ),
                          onTap: (){
                            widget.changeSendParams(
                                params:{
                                  'type':'cur_region',
                                  'val':'全部',
                                }
                            );
                            widget.changeSendParams(
                                params:{
                                  'type':'cur_area',
                                  'val':'全部',
                                }
                            );
                            //数据请求(全部)
                            widget.retrieveDataFilter();
                            setState(() {
                              area_name_list = [];
                            });
                          },
                        ),
                    ),
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
              //街道数据渲染
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: area_name_list.map((i){
                      return GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            border: cur_area == i['name']?Border(
                              left: BorderSide(
                                  color: Colors.blue,
                                  width: 1.0
                              ),
                            ):null,
                          ),
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Text(
                              i['name'],
                              style: TextStyle(
                                color:  cur_area == i['name']?Colors.blue:null,
                              ),
                            ),
                          ),
                        ),
                        onTap: (){
                          widget.changeSendParams(
                              params:{
                                'type':'cur_area',
                                'val':i['name'],
                              }
                          );
                          //发起数据请求
                          widget.retrieveDataFilter();
                        },
                      );
                    }).toList()..insert(0,
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            border: cur_area == '全部'?Border(
                              left: BorderSide(
                                  color: Colors.blue,
                                  width: 1.0
                              ),
                            ):null,
                          ),
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Text(
                              '全部',
                              style: TextStyle(
                                color:  cur_area == '全部'?Colors.blue:null,
                              ),
                            ),
                          ),
                        ),
                        onTap: (){
                          widget.changeSendParams(
                              params:{
                                'type':'cur_area',
                                'val':'全部',
                              }
                          );
                          //数据请求(全部)
                          widget.retrieveDataFilter();
                        },
                      ),
                    ),
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      case 2:
        Render = Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
          height: 240.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  '价格区间',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Wrap(
                children: selects.map((i){
                  return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: price!=i?OutlineButton(
                          onPressed: (){
                            widget.changeSendParams(
                              params:{
                                'type':'price',
                                'val':i,
                              }
                            );
                          },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          i,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ):FlatButton(
                          color: Colors.blue,
                          highlightColor: Colors.blue[700],
                          colorBrightness: Brightness.dark,
                          splashColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),

                          child: Text(
                            i,
                            style: TextStyle(
                              color:Colors.white,
                            ),
                          ),
                        onPressed: (){
                            widget.changeSendParams(
                              params:{
                                'type':'price',
                                'val':i,
                              }
                            );
                        },
                      ),
                  );
                }).toList(),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: OutlineButton(
                        child: Text('重置'),
                        onPressed: (){
                          widget.changeSendParams(
                            params:{
                              'type':'price',
                              'val':'',
                            }
                          );
                        },
                      ),
                      flex: 1,
                    ),
                    Container(
                      width: 10.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Colors.blue[300],
                        child: Text(
                          '确定',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: (){
                          widget.retrieveDataFilter();
                        },
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
        break;
      case 3:
        Render = Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 10.0),
          height: 200.0,
          child: ListView(
            children: roomList.map((i){
              return Column(
                children: [
                  GestureDetector(
                    child: Center(
                      child: Text(
                        i,
                        style: TextStyle(
                          color: room == i?Colors.blue:null,
                        ),
                      ),
                    ),
                    onTap: (){
                      widget.changeSendParams(
                        params:{
                          'type':'room',
                          'val':i,
                        }
                      );
                      widget.retrieveDataFilter();
                    },
                  ),
                  Divider(
                    color: Colors.blue,
                  )
                ],
              );
            }).toList(),
          ),
        );
        break;
      case 4:
        Render = Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
          height: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  '房屋特色',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Wrap(
                children: specialList.map((i){
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: !(special.contains(i))?OutlineButton(
                      onPressed: (){
                        List _arr = [];
                        _arr.addAll(special);
                        if(_arr.contains(i)){
                          _arr.remove(i);
                        }else{
                          _arr.add(i);
                        }
                        widget.changeSendParams(
                            params:{
                              'type':'special',
                              'val':_arr,
                            }
                        );
                      },
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(20.0),
                      // ),
                      child: Text(
                        i,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ):FlatButton(
                      color: Colors.blue,
                      highlightColor: Colors.blue[700],
                      colorBrightness: Brightness.dark,
                      splashColor: Colors.grey,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(20.0),
                      // ),

                      child: Text(
                        i,
                        style: TextStyle(
                          color:Colors.white,
                        ),
                      ),
                      onPressed: (){
                        List _arr = [];
                        _arr.addAll(special);
                        if(_arr.contains(i)){
                          _arr.remove(i);
                        }else{
                          _arr.add(i);
                        }
                        widget.changeSendParams(
                            params:{
                              'type':'special',
                              'val':_arr,
                            }
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: OutlineButton(
                        child: Text('重置'),
                        onPressed: (){
                          widget.changeSendParams(
                              params:{
                                'type':'special',
                                'val':[],
                              }
                          );
                        },
                      ),
                      flex: 1,
                    ),
                    Container(
                      width: 10.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Colors.blue[300],
                        child: Text(
                          '确定',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: (){
                          widget.retrieveDataFilter();
                        },
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
        break;
      default:
    }

    return widget.modelState != null && widget.modelState > 0 ? Positioned(
      top: 75.0,
      left: 0.0,
      right:0.0,
      bottom: 0.0,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Render,
          //遮罩层
          Expanded(
              child: GestureDetector(
                onTap: (){
                  widget.changeFilter(0);
                },
                child: Opacity(
                  opacity: 0.7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
          ),
        ],
      ),
    ):Container( width: 0.0, height: 0.0, );
  }
}
