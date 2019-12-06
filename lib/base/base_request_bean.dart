


import '../config/net_config.dart';

import '../enum/request_status_enum.dart';

import 'base_bean.dart';

abstract class BaseRequestBean<DataType extends BaseBean>{

  int code;

  String msg;

  DataType data;

  RequestStatusEnum getRequestStatus(){
      if(code==NetConfig.success){
        if(isEmpty()){
          return RequestStatusEnum.EMPTY;
        }else{
          return RequestStatusEnum.SUCCESS;
        }
      }
      if(code==NetConfig.appError){
        return RequestStatusEnum.APP_ERROR;
      }
      if(code==NetConfig.serverError){
        return RequestStatusEnum.SERVER_ERROR;
      }
      return RequestStatusEnum.SERVER_ERROR;
  }

  bool isEmpty();

  error(int code,String msg,{dynamic data});

  success(int code,dynamic data,{dynamic msg});

}