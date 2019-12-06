




import '../base/base_bean.dart';
import '../base/base_request_bean.dart';

class RequestBean<T extends BaseBean> extends BaseRequestBean<T>{

  RequestBean();

  RequestBean.type(d){
    data=d;
  }

  RequestBean.error(code,msg){
    this.code=code;
    this.msg=msg;
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
    return data.dataIsEmpty();
  }

  @override
  success(int code, dynamic jsonStr, {msg}) {
    this.code=code;
    this.msg=msg;
    this.data=data.fromJson(jsonStr);
    return this;
  }

}