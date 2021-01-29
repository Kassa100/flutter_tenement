import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/request.dart';


class PersonalInformation extends StatefulWidget{
  PersonalInformation({Key key, this.title});
  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PersonalInformation();
  }
}

//配置项类
class ConfigItem{
  ConfigItem({this.key,this.name,this.onTapHandle});
  final String key;
  final String name;
  Function onTapHandle;
}

class _PersonalInformation extends State<PersonalInformation>{
  List _configList = []; //配置项
  Map user = {}; //用户详细信息
  //初始化配置数据
  void initData(){
    _configList=[
      ConfigItem(
        key:'nickname',
        name:'昵称',
        onTapHandle:() async{
          await Navigator.pushNamed(context, 'personalInformationChange',arguments:{
            'key':'nickname',
            'name':'昵称',
            'val':user['nickname'],
          });
          getInitData();
        },
      ),
      ConfigItem(
        key:'age',
        name:'年龄',
        onTapHandle:() async{
          await Navigator.pushNamed(context, 'personalInformationChange',arguments:{
            'key':'age',
            'name':'年龄',
            'val':user['age'],
          });
          getInitData();
        },
      ),
      ConfigItem(
        key:'sex',
        name:'性别',
        onTapHandle:() async{
          await Navigator.pushNamed(context, 'personalInformationChange',arguments:{
            'key':'sex',
            'name':'性别',
            'val':user['sex'],
          });
          getInitData();
        },
      ),
      ConfigItem(
        key:'phone',
        name:'手机号',
        onTapHandle:() async{
          await Navigator.pushNamed(context, 'personalInformationChange',arguments:{
            'key':'phone',
            'name':'手机号',
            'val':user['phone'],
          });
          getInitData();
        },
      ),
    ];
  }
  //数据请求获取用户信息
  void getInitData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    if(userId == null){
      Navigator.pushReplacementNamed(context, 'loginPage');
    }else{
      var _data = await Request(context).getUser(queryParameters: {
        'userId':userId,
      });
      setState(() {
        user = _data.data;
      });
      print(user);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
    getInitData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _configList.map((e) {
            return GestureDetector(
              onTap: (){
                e.onTapHandle();
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[400],
                      width: 1,
                    )
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 10.0),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e.name
                    ),
                    Row(
                      children: [
                        Text(user[e.key] != null ? user[e.key] : '',),
                        Icon(Icons.keyboard_arrow_right,color: Colors.grey,),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}