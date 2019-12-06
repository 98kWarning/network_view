import 'package:flutter/material.dart';

class CustomViewList{

  static Widget errorView(Function onTryAgain,{String errText:'未知错误'}){
    return Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error),
          Text(errText),
          FlatButton(
            onPressed: onTryAgain,
            child: Text('点击重试'),
          )
        ],
      )
      );
  }


  static Widget emptyView(Function onTryAgain,{String emptyText:'没有数据哦'}){
    return Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.data_usage),
          Text(emptyText),
          FlatButton(
            onPressed: onTryAgain,
            child: Text('点击刷新'),
          )
        ],
      )
      );
  }

  static Widget loadingView({String loadingText:'正在加载'}){
    return Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text(loadingText)
        ],
      )
      );
  }

}