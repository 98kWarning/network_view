import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTripsDialog extends StatelessWidget {
  const MyTripsDialog(
      {Key key,
      this.content: '提示消息',
      this.leftBtnText: '取消',
      this.rightBtnText: '确定',
      this.singleBtn: false})
      : super(key: key);
  final String content;
  final String leftBtnText;
  final String rightBtnText;
  final bool singleBtn;
  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 2.0,
        type: MaterialType.transparency,
        child: Center(
          child: Container(
              //  alignment: Alignment.center,
              width: ScreenUtil.instance.setWidth(560),
              height: ScreenUtil.instance.setWidth(380),
              padding: EdgeInsets.only(top: ScreenUtil.instance.setWidth(30)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    '提示',
                    style: new TextStyle(
                      color: Color(0xFF4E5463),
                      fontSize: ScreenUtil.instance.setSp(36),
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil.instance.setSp(60)),
                    child: Center(
                      child: new Text(content,
                          style: new TextStyle(
                            color: Color(0xFF4E5463),
                            // fontWeight: FontWeight.w800,
                            fontSize: ScreenUtil.instance.setSp(32),
                          ),
                          overflow: TextOverflow.fade),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      singleBtn
                          ? Container()
                          : new Expanded(
                              flex: 1,
                              child: _getCancelButton(context),
                            ),
                      new Expanded(
                        flex: 1,
                        child: _getSureButton(context),
                      )
                    ],
                  ),
                ],
              ),
              decoration: new BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius:
                    BorderRadius.circular(ScreenUtil.instance.setWidth(16)),
              )),
        ));
  }

  /** 左边取消按钮 */
  Widget _getCancelButton(context) {
    return new Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: Colors.lightBlue,
          onTap: () {
            Navigator.pop(context, false);
          },
          child: Container(
              alignment: Alignment.center,
              height: ScreenUtil.instance.setWidth(100),
              child: new Text(
                leftBtnText,
                style: new TextStyle(
                  color: Color(0xFF666666),
                  fontSize: ScreenUtil.instance.setSp(32),
                ),
              ),
              decoration: new BoxDecoration(
                  border: new Border.all(
                    color: Color(0xFFE5E5E5),
                    width: ScreenUtil.instance.setWidth(1),
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft:
                          Radius.circular(ScreenUtil.instance.setWidth(16))))),
        ));
  }

  /** 右边确定按钮 */
  Widget _getSureButton(context) {
    return Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: Colors.greenAccent,
          onTap: () {
            Navigator.pop(context, true);
          },
          child: new Container(
              alignment: Alignment.center,
              height: ScreenUtil.instance.setWidth(100),
              child: new Text(
                rightBtnText,
                style: new TextStyle(
                  color: Color(0xFF3594F7),
                  fontSize: ScreenUtil.instance.setSp(32),
                ),
              ),
              decoration: new BoxDecoration(
                  border: new Border.all(
                    color: Color(0xFFE5E5E5),
                    width: ScreenUtil.instance.setWidth(1),
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: singleBtn?Radius.circular(ScreenUtil.instance.setWidth(16)):Radius.circular(0),
                      bottomRight:
                          Radius.circular(ScreenUtil.instance.setWidth(16))))),
        ));
  }
}
