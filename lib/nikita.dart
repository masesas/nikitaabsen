import 'dart:convert';

class Nikita {

}


class Nson {
  dynamic internal;

  Nson(this.internal) {
    if (internal is String) {
      _error = internal.toString();
    }
  }

  String _error = '';
  int _errorCode = 0;

  String getError() {
    return getMessage();
  }

  String getMessage() {
    return _error;
  }

  int getStatusCode() {
    return _errorCode;
  }

  Nson setMessage(int code, String message) {
    _errorCode = code;
    _error = message;
    return this;
  }

  static Nson newObject() {
    Map map = {};
    return Nson(map);
  }

  static Nson newArray() {
    List list = []; //growableList
    return Nson(list);
  }

  static Nson parseJson(String nson) {
    try {
      return Nson(json.decode(nson));
    } on Exception catch (_) {
      return Nson(null);
    }
  }

  Nson set(String key, dynamic val) {
    if (internal is Map) {
      Map map = _castAsMap(internal);
      map.update(key, (value) => _value(val), ifAbsent: () => _value(val));
    }
    return this;
  }

  void remove(String key) {
    if (internal is Map) {
      Map map = _castAsMap(internal);
      if (map.containsKey(key)) {
        map.remove(key);
      }
    }
  }

  void removeIn(int index) {
    if (internal is List) {
      List list = _castAsList(internal);
      if (list.length > index && index >= 0) {
        list.removeAt(index);
      }
    }
  }

  Nson add(dynamic val) {
    if (internal is List) {
      List list = _castAsList(internal);
      list.add(_value(val));
    }
    return this;
  }

  bool containsKey(String key) {
    if (internal is Map) {
      Map map = _castAsMap(internal);
      return map.containsKey(key);
    }
    return false;
  }

  bool containsValue(String val) {
    if (internal is Map) {
      Map map = _castAsMap(internal);
      return map.containsValue(val);
    } else if (internal is List) {
      List list = _castAsList(internal);
      return list.contains(val);
    }
    return false;
  }

  Nson getObjectKeys() {
    if (internal is Map) {
      List<String> keys = [];
      Map map = _castAsMap(internal);
      map.keys.forEach((k) => keys.add(k));
      return Nson(keys);
    }
    return Nson(null);
  }

  Nson getObjectValues() {
    if (internal is Map) {
      List<String> vals = [];
      Map map = _castAsMap(internal);
      map.values.forEach((k) => vals.add(k));
      return Nson(vals);
    } else if (internal is List) {
      List<String> vals = [];
      List list = _castAsList(internal);
      list.forEach((v) => vals.add(v));
      return Nson(vals);
    }
    return Nson(null);
  }
  T? _castN<T>(x) {
    if (x is T) {
      return x;
    } else {
      return null;
    }
  }
  T _cast<T>(x, T nc) {
    if (x is T) {
      return x;
    } else {
      return nc;
    }
  }
  Nson _castAsNson(x) {
    if (x is Nson) {
      return x;
    } else {
      return Nson.newObject();
    }
  }
  List _castAsList(x) {
    if (x is List) {
      return x;
    } else {
      return [];
    }
  }
  Map _castAsMap(x) {
    if (x is Map) {
      return x;
    } else {
      return {};
    }
  }

  int size() {
    if (internal is List) {
      List list = _castAsList(internal);
      return list.length;
    } else if (internal is Map) {
      Map map = _castAsMap(internal);
      return map.length;
    } else {
      return 0;
    }
  }

  dynamic _value(dynamic val) {
    if (val is Nson) {
      return _cast<Nson>(val, Nson.newObject()).internal;
    } else if (val is List ||
        val is Map ||
        val is double ||
        val is int ||
        val is String) {
      return val;
    } else {
      return val;
    }
  }

  Nson getByIndex(int index) {
    if (internal is List) {
      List list = _castAsList(internal);
      if (index >= 0 && index < list.length) {
        return new Nson(internal[index]);
      }
    }
    return Nson(null);
  }

  Nson get(String key) {
    if (internal is Map) {
      Map map = _castAsMap(internal);
      if (map.containsKey(key)) {
        return new Nson(internal[key]);
      }
    }
    return Nson(null);
  }

  // void sort([int compare(dynamic a, dynamic b)]) {
  //   if (internal is List) {
  //     //List list = _castAsList(internal);
  //     //list.sort(compare);
  //   }
  // }

  //final intRegex = RegExp(r'\s+(\d+)\s+', multiLine: true);
  //final doubleRegex = RegExp(r'\s+(\d+\.\d+)\s+', multiLine: true);
  //final timeRegex = RegExp(r'\s+(\d{1,2}:\d{2})\s+', multiLine: true);

  final numberRegex = RegExp(r'-?\d+(\.\d+)?');
  final doubleRegex = RegExp(r'^[-+]?[0-9]*.?[0-9]+([eE][-+]?[0-9]+)?$');
  final intRegex = RegExp(r'-?\d+');

  bool isNumber() {
    String str = asString();
    return intRegex.hasMatch(str) || doubleRegex.hasMatch(str);
  }

  bool isNull() {
    return internal == null;
  }

  bool isNsonArray() {
    return internal is List;
  }

  bool isNsonObject() {
    return internal is Map;
  }

  bool isNson() {
    return isNsonArray() || isNsonObject();
  }

  bool isDecimal() {
    return doubleRegex.hasMatch(asString());
  }

  bool isDouble() {
    return doubleRegex.hasMatch(asString());
  }

  bool isString() {
    return internal is String;
  }

  bool isBoolean() {
    return internal == true || internal == false;
  }

  String asString() {
    if (internal is String) {
      return internal ?? '';
    } else if (internal is Nson) {
      Nson ninternal = _castAsNson(internal).internal;
      return (ninternal ?? '').toString();
    } else if (internal == null) {
      return '';
    }
    return "$internal";
  }

  int asInteger() {
    try {
      String str = asString();
      if (intRegex.hasMatch(str)) {
        return int.parse(str);
      }
    } on Exception catch (_) {}
    return 0;
  }

  double asDouble() {
    try {
      String str = asString();
      if (doubleRegex.hasMatch(str)) {
        return double.parse(str);
      }
    } on Exception catch (_) {}
    return 0;
  }

  String asDecimalString() {
    /*if (isNumber()){
        Decimal convertedNum = Decimal.parse(asString());
        return convertedNum.toString();
      }*/
    return asDouble().toString();
  }

  bool asBoolean() {
    String str = asString().toLowerCase().trim();
    return str == 'true';
  }

  String toJson() {
    try {
      return json.encode(internal);
    } on Exception catch (_) {
      return '';
    }
  }

  String toStream() {
    //new Nson
    try {
      Map map = {
        'statuscode': getStatusCode(),
        'message': getMessage(),
        'body':
            isNsonObject() ? asMap() : (isNsonArray() ? asList() : asString()),
        'nfid': 'Nson'
      };
      return json.encode(map);
    } on Exception catch (_) {
      return '';
    }
  }

  Map asMap() {
    return _castN<Map>(internal) ?? {};
  }

  List asList() {
    return _castN<List>(internal) ?? [];
  }
}

class Utils {}

class Internet {}
