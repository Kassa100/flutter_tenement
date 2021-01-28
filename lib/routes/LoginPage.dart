import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../service/request.dart';


class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage>{
  GlobalKey _formkey = new GlobalKey<FormState>();
  String _uname;
  String _password;
  FocusNode blankNode = FocusNode();
  //登陆操作
  _login(context) async {
    if(Form.of(context).validate()){
      FocusScope.of(context).requestFocus(blankNode);
      Form.of(context).save();
      //验证通过  提交数据
      var _data = await Request(context).sendLogin(queryParameters: {
        'userName':_uname,
        'userpwd':_password,
      });
      if(_data.msg != 'ok'){
        Toast.show(_data.msg,context,duration: Toast.LENGTH_LONG,gravity: Toast.CENTER);
      }else{
        //登录成功 信息保存
        _storageUserInfo(context,_data);
        Toast.show('登录成功',context,duration: Toast.LENGTH_LONG,gravity: Toast.CENTER);
      }
    }
  }
  //信息保存操作
  _storageUserInfo(context,userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userData?.data['id']);
    Future.delayed(Duration(seconds: 1),(){
      // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      Navigator.of(context).pop();
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 24.0),
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).requestFocus(blankNode);
            },
            child: Form(
              key: _formkey,
              autovalidateMode: AutovalidateMode.disabled, //开启自动校验
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      // labelText: '用户名',
                      hintText: '用户名',
                      icon: Icon(
                        Icons.person,
                        color: Colors.blue[400],
                      ),
                    ),
                    //用户名校验
                    validator: (v){
                      return v.trim().length > 0 ? null:'用户名不能为空';
                    },
                    onSaved: (v){
                      _uname = v;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      // labelText: '密码',
                      hintText: '密码',
                      icon: Icon(
                        Icons.lock,
                        color: Colors.blue[400],
                      ),
                    ),
                    //密码校验
                    validator: (v){
                      return v.trim().length > 5 ?null:'密码不能少于6位';
                    },
                    obscureText: true,
                    onSaved: (v){
                      _password = v;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Text(
                          '立即注册',
                          style: TextStyle(color: Colors.blue[400]),
                        ),
                        onTap: (){
                          FocusScope.of(context).requestFocus(blankNode);
                          Navigator.pushNamed(context, 'registerPage');
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Builder(builder: (context){
                            return RaisedButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                child: Text('取消'),
                                color: Colors.blue[400],
                                textColor: Colors.white,
                                padding: EdgeInsets.all(15.0),
                              );
                            },
                          ),
                        ),
                        Container(width: 10.0),
                        Expanded(
                          flex: 1,
                          child: Builder(builder: (context){
                            return RaisedButton(
                              onPressed: (){
                                _login(context);
                              },
                              child: Text('登录'),
                              color: Colors.blue[400],
                              textColor: Colors.white,
                              padding: EdgeInsets.all(15.0),
                            );
                          },),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        ),
      ),
    );
  }
}