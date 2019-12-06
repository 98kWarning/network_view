import 'dart:convert' show json;
abstract class BaseBean{

  Map<String, dynamic> toMap() {
    return json.decode(toString());
  }

  fromJson(jsonRes);

  bool dataIsEmpty();
}
