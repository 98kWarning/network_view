


import 'package:flutter/material.dart';
import '../enum/request_status_enum.dart';
import '../base/base_request_bean.dart';
import '../view/custom_view_list.dart';


class BaseViewManager extends StatefulWidget {

  final Function defaultViewFunction;

  final BaseRequestBean request;

  final Function tryAgain;

  final String emptyText;

  BaseViewManager({this.defaultViewFunction,this.request,this.tryAgain, this.emptyText='没有数据'});

  @override
  _BaseViewManagerState createState() => _BaseViewManagerState();

}

class _BaseViewManagerState extends State<BaseViewManager> {

  bool showLoading=false;

  @override
  void initState() {
    super.initState();
  }

  Widget _getDefaultView(){
    return widget.defaultViewFunction();
  }

  void _onTryAgain(){
      setState(() {
        showLoading=true;
      });
      widget.tryAgain();
  }

  @override
  Widget build(BuildContext context) {

    if(widget.request==null||showLoading){
      showLoading=false;
      return CustomViewList.loadingView();
    }

    switch(widget.request.getRequestStatus()){
      case RequestStatusEnum.SUCCESS:
        return _getDefaultView();
        break;
      case RequestStatusEnum.EMPTY:
        return CustomViewList.emptyView(_onTryAgain);
        break;
      case RequestStatusEnum.SERVER_ERROR:
         return CustomViewList.errorView(_onTryAgain,errText: widget.request.msg==null?"SERVER_ERROR":widget.request.msg);
        break;
      case RequestStatusEnum.NETWORK_ERROR:
         return CustomViewList.errorView(_onTryAgain,errText: '请检查网络');
        break;
      case RequestStatusEnum.APP_ERROR:
         return CustomViewList.errorView(_onTryAgain,errText: 'APP_ERROR');
        break;
    }
     return CustomViewList.errorView(_onTryAgain,errText: '未知错误');
  }

  @override
  void dispose() {

    super.dispose();
  }


}
