import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/request.dart';
import 'package:toast/toast.dart';

class PersonalInformationChange extends StatefulWidget {
  PersonalInformationChange({Key key,this.title,this.arg});
  final String title;
  final Map arg;
  @override
  _PersonalInformationChangeState createState() {
    return _PersonalInformationChangeState();
  }
}

class _PersonalInformationChangeState extends State<PersonalInformationChange> {
  FocusNode focusNode1 = new FocusNode(); //数据框焦点控制
  final TextEditingController _controller = new TextEditingController();


  String title = '';//名称
  String key = '';//字段

  //校验函数
  Function reg;
  //默认值
  String placeHold = '';

  //配置函数
  void render(){
    title = widget.arg['name'];
    key = widget.arg['key'];
    _controller.text = widget.arg['val'];

    switch(widget.arg['key']){
      case 'nickname':{
        placeHold = '请输入昵称';
        reg=(v){
          if(v == ''){
            return '不能为空';
          }else{
            return '';
          }
        };
      }
      break;
      case 'sex':{
        placeHold = '请输入性别';
        reg=(v){
          if(v == '男' || v == '女'){
            return '';
          }else{
            return '只能输入男或女';
          }
        };
      }
      break;
      case 'age':{
        placeHold = '请输入年龄';
        reg=(v){
          if(RegExp(r'^\d{1,2}$').hasMatch(v)){
            return '';
          }else{
            return '请输入两位数字';
          }
        };
      }
      break;
      case 'phone':{
        placeHold = '请输入手机号';
        reg=(v){
          if(RegExp(r'^1[3456789]\d{9}$').hasMatch(v)){
            return '';
          }else{
            return '请输入正确的手机号';
          }
        };
      }
      break;

    }
  }

  //数据发送
  void sendData()async {
    String msg = reg(_controller.text);
    if(msg != ''){
      Toast.show(msg,context,duration:Toast.LENGTH_SHORT,gravity:Toast.CENTER);
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    if(userId == null){
      Navigator.pushNamed(context, 'loginPage');
    }else{
      var _data = await Request(context).changeUser(queryParameters: {
        'userId':userId,
        key:_controller.text,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    render();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 30.0,
            margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
            child: Row(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title),
                Container(width: 10.0,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.center,
                      controller: _controller,
                      focusNode: focusNode1,
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                      onEditingComplete: (){
                        setState(() {
                          focusNode1.unfocus();
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: placeHold,
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 14),

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                onPressed: (){
                  focusNode1.unfocus();
                  Navigator.pop(context);
                },
                child: Text('取消'),
                color: Colors.grey[400],
                textColor: Colors.white,
              ),
              RaisedButton(
                onPressed: (){
                  focusNode1.unfocus();
                  sendData();
                },
                child: Text('确定'),
                color: Colors.blue[400],
                textColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
