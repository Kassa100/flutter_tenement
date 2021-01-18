import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import '../common/global.dart';

import '../models/home.dart';
import '../models/project_list.dart';
import '../models/region.dart';
import '../models/register.dart';
import '../models/sendCollection.dart';
import '../models/sendOrder.dart';
import '../models/user.dart';
import '../models/changeUser.dart';
import '../models/collection.dart';
import '../models/order.dart';

class Request {
  Request([this.context]) {
    _options = Options(extra: {'context': context});
  }
  BuildContext context;
  Options _options;
  static Dio dio = new Dio(
    BaseOptions(
      baseUrl: 'http://192.168.2.127:8080/',
      // headers: {
      //   HttpHeaders.acceptHeader:
      //       'application/vnd.github.squirrel-girl-preview,'
      //           'application/vnd.github.symmetra-preview+json'
      // },
    ),
  );
  static void init() {
    dio.interceptors.add(Global.netCache);
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;

    // if (!Global.isRelease) {
    //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //       (client) {
    //     client.findProxy = (uri) {
    //       return 'PROXY 192.168.2.127:8080';
    //     };
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    //   };
    // }
  }

  // 首页数据获取
  Future<Home> getHome({refresh = false}) async {
    if (refresh) {
      _options.extra.addAll({'refresh': true});
    }
    var r = await dio.get<Map>(
      'api/index',
      options: _options,
    );
    print(r);
    return Home.fromJson(r.data);
  }

  // 获取房源列表
  Future<Project_list> getProjectList(
      {Map<String, dynamic> queryParameters, refresh = false}) async {
    if (refresh) {
      _options.extra.addAll({'refresh': true});
    }
    var r = await dio.get<Map>(
      'api/project',
      options: _options,
      queryParameters: queryParameters,
    );
    print(r);
    return Project_list.fromJson(r.data);
  }

  // 获取城市列表
  Future<Region> getRegionList() async {
    var r = await dio.get<Map>(
      'api/city',
      options: _options,
    );
    print(r);
    return Region.fromJson(r.data);
  }

  // 获取收藏列表
  Future<SendCollection> sendCollection(
      {Map<String, dynamic> queryParameters, refresh = false}) async {
    var r = await dio.post<Map>(
      'api/collect',
      options: _options,
      data: queryParameters,
    );
    print(r);
    return SendCollection.fromJson(r.data);
  }

  // 获取订阅列表
  Future<SendOrder> sendOrder(
      {Map<String, dynamic> queryParameters, refresh = false}) async {
    var r = await dio.post<Map>(
      'api/order',
      options: _options,
      data: queryParameters,
    );
    print(r);
    return SendOrder.fromJson(r.data);
  }

  // 获取房源列表
  Future<Order> getOrderList(
      {Map<String, dynamic> queryParameters, refresh = false}) async {
    if (refresh) {
      _options.extra.addAll({'refresh': true});
    }
    var r = await dio.get<Map>(
      'api/order',
      options: _options,
      queryParameters: queryParameters,
    );
    print(r);
    return Order.fromJson(r.data);
  }

  // 获取收藏列表
  Future<Collection> getCollectionList(
      {Map<String, dynamic> queryParameters, refresh = false}) async {
    if (refresh) {
      _options.extra.addAll({'refresh': true});
    }
    var r = await dio.get<Map>(
      'api/collect',
      options: _options,
      queryParameters: queryParameters,
    );
    print(r);
    return Collection.fromJson(r.data);
  }

  // 登录
  Future<User> sendLogin(
      {Map<String, dynamic> queryParameters, refresh = false}) async {
    var r = await dio.post<Map>(
      'api/login',
      options: _options,
      data: queryParameters,
    );
    print(r);
    return User.fromJson(r.data);
  }

  // 注册
  Future<Register> sendRegister(
      {Map<String, dynamic> queryParameters, refresh = false}) async {
    var r = await dio.post<Map>(
      'api/register',
      options: _options,
      data: queryParameters,
    );
    print(r);
    return Register.fromJson(r.data);
  }

  // 获取用户信息
  Future<User> getUser({Map<String, dynamic> queryParameters}) async {
    _options.extra.addAll({'noCache': true});
    var r = await dio.get<Map>(
      'api/collect',
      options: _options,
      queryParameters: queryParameters,
    );
    print(r);
    return User.fromJson(r.data);
  }

  // 修改用户信息
  Future<ChangeUser> changeUser(
      {Map<String, dynamic> queryParameters, refresh = false}) async {
    var r = await dio.post<Map>(
      'api/changeUser',
      options: _options,
      data: queryParameters,
    );
    print(r);
    return ChangeUser.fromJson(r.data);
  }
}
