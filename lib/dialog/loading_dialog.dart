import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';



/** 
// ignore: must_be_immutable
class LoadingDialog extends StatefulWidget {
  String loadingText;
  bool canCancel;
  Function isShowing;

  CancelToken cancelToken=CancelToken();

  _LoadingDialog _loadingDialog;

  LoadingDialog(
        {
          Key key,
          this.loadingText = "加载中...",
          this.canCancel = false,
          this.isShowing
        }
     ): super(key: key);

  @override
  State<LoadingDialog> createState(){
    _loadingDialog=_LoadingDialog();
    return _loadingDialog;
  }

  void closeDialog() {
    if(_loadingDialog!=null)
    _loadingDialog.closeDialog();
  }

  void setLoadingText(String text){
     if(_loadingDialog!=null)
    _loadingDialog.setLoadingText(text);
  }
}

class _LoadingDialog extends State<LoadingDialog> {
  _dismissDialog() {
    Navigator.of(context).pop();
  }

  setLoadingText(String text){
    setState(() {
      widget.loadingText=text;
    });
  }

  _cancel(){
    if(widget.canCancel){
      widget.cancelToken.cancel('取消');
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
    if(null!= widget.isShowing)
    widget.isShowing();
    return WillPopScope(
      onWillPop: (){
        _cancel();
        return Future.value(false);
      },
      child: Material(
          type: MaterialType.transparency,
          child: new Center(
            child: new SizedBox(
              width: 150.0,
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
                    new CircularProgressIndicator(),
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

*/


class LoadingDialog extends StatelessWidget {

  factory LoadingDialog.withSimple({Key key,String loadingText:'加载中',bool canCancel,Function isShowing}){

    CancelToken cancelToken=new CancelToken();

    return new  LoadingDialog(
        key:key,
        loadingText: loadingText,
        canCancel: canCancel,
        isShowing: isShowing,
        cancelToken: cancelToken,
    );
  }

  const LoadingDialog({Key key, this.loadingText = "加载中...", this.canCancel= false, this.isShowing,this.cancelToken }) : super(key: key);

  final String loadingText;
  final bool canCancel;
  final Function isShowing;

  final CancelToken cancelToken;

  dismissDialog(context){
     Navigator.of(context).pop();
  }

  closeDialog(context){
    if(canCancel){
      try{
        cancelToken.cancel('取消');
      }catch (e){
        dismissDialog(context);
      }
    }else{
      print("当前操作不可取消，请耐心等待");
    }
  }

  @override
  Widget build(BuildContext context) {
    if(null!= isShowing){
      isShowing();
    }
    return WillPopScope(
      onWillPop: (){
        closeDialog(context);
        return Future.value(false);
      },
      child: Material(
          type: MaterialType.transparency,
          child: new Center(
            child: new SizedBox(
              width: 150.0,
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
                    new CircularProgressIndicator(),
                    new Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                      ),
                      child: new Text(
                        loadingText,
                        style: new TextStyle(fontSize: 12.0),
                      ),
                    ),
                    FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: (){
                          closeDialog(context);
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