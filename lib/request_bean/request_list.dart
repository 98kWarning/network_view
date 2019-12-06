



import '../base/base_request_bean.dart';

import '../base/base_bean.dart';

class RequestList<T extends BaseBean> extends BaseRequestBean{

  int code;

  String msg;

  List<T> dataList;

  RequestList.type(d){
    data=d;
  }

  @override
  String toString() {
    return 'RequestBean{code: $code, msg: $msg, data: $data}';
  }

  @override
  error(int code, String msg, {data}) {
    this.code=code;
    this.msg=msg;
    this.data=data;
    return  this;
  }

  @override
  bool isEmpty() {
    return dataList.isEmpty;
  }

  @override
  success(int code, dynamic jsonStr, {msg}) {
    this.code=code;
    this.msg=msg;
    this.dataList=[];
    for (var listItem in jsonStr == null ? [] : jsonStr){
      dataList.add(listItem == null ? null : data.fromJson(listItem));
    }
    return this;
  }


}