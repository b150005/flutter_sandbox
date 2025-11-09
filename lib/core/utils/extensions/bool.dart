import 'nullable.dart';

extension NullableBool on bool? {
  bool orTrue({String? objectName}) => orElse(true, objectName: objectName);

  bool orFalse({String? objectName}) => orElse(false, objectName: objectName);
}

extension BoolParser on bool {
  static bool? tryParse(String value) {
    if (value == true.toString()) {
      return true;
    }

    if (value == false.toString()) {
      return false;
    }

    return null;
  }
}
