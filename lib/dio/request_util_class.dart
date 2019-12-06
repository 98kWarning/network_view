import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../config/net_config.dart';
import '../base/base_request_bean.dart';
import '../dialog/loading_dialog.dart';
import '../dialog/my_trips_dialog.dart';

import 'dio_utiil.dart';

class RequestUtil{

  static Future<T> baseRequest<T extends BaseRequestBean>(
    T t,
    String url,
    dynamic data,
      {
      BuildContext context,
      bool canCancel=true,
      bool showResult=true,
      bool showError=true,
      bool showSuccess=false,
      String successText,
      String failText:'操作失败'
      }
    )async{
        if(url.isEmpty){
          return Future.value(t.error(NetConfig.requestException,'url不可为空！'));
        }
        // bool finsh=false;
        LoadingDialog loadingDialog;
        if(context!=null){
          loadingDialog=LoadingDialog.withSimple(canCancel: canCancel);
          // loadingDialog=LoadingDialog(canCancel: canCancel);
            _showDialog(context,loadingDialog);

          // Future.delayed(Duration(seconds: 2),(){
          //   if(!finsh)
          //   _showDialog(context,loadingDialog);
          // });

        }
        // T dioError;
        // T result;

        bool isSuccess=false;
        String errorText="请求错误";
        Response response = await DioUtil.instance.post(url, data,cancelToken:loadingDialog!=null?loadingDialog.cancelToken:null)
        .catchError((err){
            print("----networkErr----$err");
            if (CancelToken.isCancel(err)) {
              print('Request canceled! '+ err.message);
              errorText='取消成功';
              t=t.error(NetConfig.userCancel,'已取消');
            }else{
              errorText=err.message;
              t=t.error(NetConfig.requestException,err.message);
            }
        }).whenComplete((){
            if(loadingDialog!=null)
            loadingDialog.dismissDialog(context);
          /**
           * 
            finsh=true;
            Future.delayed(Duration(microseconds: 500),(){
               if(null!=loadingDialog){
                loadingDialog.closeDialog();
              }
            });
             */
        });
        print("====getData=====:"+response.toString());

      if(response!=null){
        if(response.statusCode==HttpStatus.OK){
          if (response.data[NetConfig.code]==NetConfig.success) {
            isSuccess=true;
            successText=response.data[NetConfig.message];
            t=t.success(response.data[NetConfig.code],response.data[NetConfig.data]);

          }else if(response.data[NetConfig.code]==NetConfig.tokenExpired){
            NetConfig.toLogin();
            errorText=response.data[NetConfig.message];
            t =t.error(NetConfig.tokenExpired,'登录过期，请重新登录');
          }else{
            errorText=response.data[NetConfig.message];
            t=t.error(response.data[NetConfig.code], failText==null?'操作失败':'未知错误：${response.data[NetConfig.message]}');
          }
        }else{
           t =t.error(NetConfig.networkError, "网络连接失败");
        }
      }else{
        t =t.error(NetConfig.requestException, "请求出错");
      }
      await _showResult(
        context,
        isSuccess,
        showResult,
        showSuccess: showSuccess,
        successText: successText,
        showError:showError, 
        errorText: errorText
        );
      return Future.value(t);
}

static Future _showResult(
  BuildContext context,
  bool isSuccess,
  bool showResult,
  {
    bool showSuccess,
    String successText,
    bool showError,
    String errorText
  }
  )async{
  if(context!=null){
    if(showResult){
      MyTripsDialog tripsDialog;
      if(isSuccess&&showSuccess){
        tripsDialog=MyTripsDialog(content: successText,singleBtn: true);
      }
      if(!isSuccess&&showError){
         tripsDialog=MyTripsDialog(content: errorText,singleBtn: true);
      }
      if(tripsDialog!=null){
        return _showDialog(context, tripsDialog);
      }else{
        return null;
      }
    }
  }
  return null;
}

static Future _showDialog(BuildContext context,Widget widget)async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return widget;
        },
      );
  }
}