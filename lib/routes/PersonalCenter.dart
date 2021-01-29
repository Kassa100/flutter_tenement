import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/BottomNavWidget.dart';
import 'package:url_launcher/url_launcher.dart';
class PersonalCenter extends StatefulWidget {
  PersonalCenter({Key key, this.title});
  final String title;
  @override
  PersonalCenterState createState() {
    return PersonalCenterState();
  }
}

class PersonalCenterState extends State<PersonalCenter> {
  //进入页面是调用
  @override
  void initState(){
    super.initState();
    _getInitData();
  }

  //退出登录相关
  _removeUserInfo(context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    Navigator.pushReplacementNamed(context, 'loginPage');
  }
  //用户信息校验
  _getInitData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    if(userId == null){
      Navigator.pushReplacementNamed(context, 'loginPage');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavWidget(
        select: 3,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //个人信息
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, 'personalInformation');
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[400],
                      width: 1,
                    ),
                  )
                ),
                margin: EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 10.0),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.perm_identity,color: Colors.blue[400],),
                        SizedBox(width: 10.0,),
                        Text('个人信息')
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_right,color: Colors.blue[400],),
                  ],
                ),
              ),
            ),
            //我的收藏
            GestureDetector(
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, 'collectListPage', (route) => false);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[400],
                        width: 1,
                      ),
                    )
                ),
                padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 10.0),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.collections,color: Colors.blue[400],),
                        SizedBox(width: 10.0,),
                        Text('我的收藏')
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_right,color: Colors.blue[400],),
                  ],
                ),
              ),
            ),
            //我的预约
            GestureDetector(
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, 'orderListPage', (route) => false);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[400],
                        width: 1,
                      ),
                    )
                ),
                padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 10.0),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.subtitles,color: Colors.blue[400],),
                        SizedBox(width: 10.0,),
                        Text('我的预约')
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_right,color: Colors.blue[400],),
                  ],
                ),
              ),
            ),
            //联系客服
            GestureDetector(
              onTap: () async{
                String phone = 'tel:15088888888';
                if(await canLaunch(phone)){
                  await launch(phone);
                }else{
                  throw 'Could not launch $phone';
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[400],
                        width: 1,
                      ),
                    )
                ),
                padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 10.0),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.contact_phone,color: Colors.blue[400],),
                        SizedBox(width: 10.0,),
                        Text('联系客服')
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_right,color: Colors.blue[400],),
                  ],
                ),
              ),
            ),
            //退出登录
            Container(
              margin: EdgeInsets.only(top: 50.0),
              padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 10.0),
              child: RaisedButton(
                onPressed: (){
                  _removeUserInfo(context);
                },
                color: Colors.red[400],
                child: Text(
                  '退出登录',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
