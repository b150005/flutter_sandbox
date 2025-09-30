import 'nullable.dart';

extension NullableBool on bool? {
  bool orTrue({String? objectName}) => orElse(true, objectName: objectName);

  bool orFalse({String? objectName}) => orElse(false, objectName: objectName);
}
