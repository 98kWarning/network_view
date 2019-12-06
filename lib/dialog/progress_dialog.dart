import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// ignore: must_be_immutable
class ProgressDialog extends StatefulWidget {
  String loadingText;
  bool canCancel;
  Function isShowing;

  CancelToken cancelToken=CancelToken();

  _ProgressDialog _loadingDialog;

  ProgressDialog(
        {
          Key key,
          this.loadingText = "上传中...",
          this.canCancel = false,
          this.isShowing
        }
     ): super(key: key);

  @override
  State<ProgressDialog> createState(){
    _loadingDialog=_ProgressDialog();
    return _loadingDialog;
  }

  void closeDialog() {
      if(null!=_loadingDialog)
    _loadingDialog.closeDialog();
  }

  void onSendProgress(int now,int all){
      if(null!=_loadingDialog)
      _loadingDialog.onSendProgress(now, all);
  }


}

class _ProgressDialog extends State<ProgressDialog> {
  _dismissDialog() {
    Navigator.of(context).pop();
  }

  double value;

  // int all;

  // int now;

  void onSendProgress(int now,int all){
      setState(() {
       value=now/all; 
      });
  }

  _cancel(){
    if(widget.canCancel){
      // widget.cancelToken=CancelToken();
      widget.cancelToken.cancel('userCancel');
    }else{
      print("当前操作不可取消，请耐心等待");
    }
  }

  closeDialog(){
    _dismissDialog();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.isShowing!=null){
      widget.isShowing();
    }
    return WillPopScope(
      onWillPop: (){
        _cancel();
        return Future.value(false);
      },
      child: Material(
          type: MaterialType.transparency,
          child: new Center(
            child: new SizedBox(
              width: 250.0,
              height: 150.0,
              child: new Container(
                decoration: ShapeDecoration(
                  color: Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new LinearProgressIndicator(
                        value: value,
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                      ),
                      child: new Text(
                        widget.loadingText,
                        style: new TextStyle(fontSize: 12.0),
                      ),
                    ),
                    FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: (){
                          _cancel();
                        },
                        child: Text(
                          "取消",
//                          style: new TextStyle(fontSize: 12.0),
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}