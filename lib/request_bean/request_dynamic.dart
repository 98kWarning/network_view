




import '../base/base_request_bean.dart';

class RequestDynamic extends BaseRequestBean{

  RequestDynamic();

  RequestDynamic.type(d){
    data=d;
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
    return false;
  }

  @override
  success(int code, dynamic jsonStr, {msg}) {
    this.code=code;
    this.msg=msg;
    this.data=jsonStr;
    return  this;
  }

}