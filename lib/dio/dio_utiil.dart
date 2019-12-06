import 'package:dio/dio.dart';

import 'dart:io';

import 'package:network_view/config/net_config.dart';
class DioUtil {
  // 工厂模式
  factory DioUtil() =>_getInstance();

  static DioUtil get instance => _getInstance();

  static DioUtil _instance;

  int _connectTimeout=7000;

  int _receiveTimeout=12000;

  static Dio _dio;

  void set (Dio dio){
    _dio=dio;
  }

  DioUtil._internal() {
    // 初始化
    //'Content-Type': 'application/x-www-form-urlencoded'
    BaseOptions options = BaseOptions(
        method: "post",
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        });
    _dio=Dio();
    _dio.options=options;
  }

  static DioUtil _getInstance() {
    if (_instance == null) {
      _instance = new DioUtil._internal();
    }
    return _instance;
  }

  Future<Response> post(String url,dynamic data,{CancelToken cancelToken})async{
    /**
     * 
    Map<String,dynamic> sendData=Map();
    sendData['k']=GlobalData.TOKEN;
    if(null!=data){
      var json = data is Map?jsonEncode(data):data;
      sendData['p']=json;
    }
     */

    print("====url=====:${NetConfig.baseUrl+url}");

    print("====sendData=====:$data");
    return _dio.post(NetConfig.baseUrl+url.trim(),queryParameters: data,cancelToken: cancelToken);
    // return _dio.get(API.BASE_URL+url,queryParameters: data,cancelToken: cancelToken);

  }

/**
 * 
  Future<Response> upload(String url,String fileName,List<File> fileList,{CancelToken cancelToken,Function onSendProgress})async{
    FormData formData=FormData();
    if(fileList.length==1){
      formData.add(fileName,UploadFileInfo(fileList[0],"$fileName.jpg"));
    }else{
      List<UploadFileInfo> uploadInfoList=[];
      for(File file in fileList){
        uploadInfoList.add(UploadFileInfo(file,"${file.path}.jpg"));
      }
      formData.add(fileName,uploadInfoList);
    }
    formData.add('s', url);
    formData.add('k', StaticValue.token);
    print("---sendFile---:"+formData.toString());
    return _dio.post(_baseApi,data:formData,cancelToken: cancelToken,onSendProgress:onSendProgress);
  }
 */
}