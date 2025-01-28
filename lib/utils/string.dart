/// 文字列を指定された長さで分割する関数
///
/// [text] 分割する対象の文字列
/// [maxLength] 1つの文字列の最大長
/// [separator] 分割時に使用する区切り文字（デフォルトは半角スペース）
/// [trimResult] 分割後の文字列の前後の空白を削除するかどうか（デフォルトはtrue）
///
/// Returns: 分割された文字列のリスト
List<String> splitStringByLength(
  String text, {
  required int maxLength,
  String separator = ' ',
  bool trimResult = true,
}) {
  if (text.isEmpty) {
    return [];
  }

  if (text.length <= maxLength) {
    return [trimResult ? text.trim() : text];
  }

  final List<String> result = [];
  final List<String> words = text.split(separator);
  String currentLine = '';

  for (final word in words) {
    if (currentLine.isEmpty) {
      currentLine = word;
    } else {
      final nextLine = '$currentLine$separator$word';
      if (nextLine.length <= maxLength) {
        currentLine = nextLine;
      } else {
        if (trimResult) {
          result.add(currentLine.trim());
        } else {
          result.add(currentLine);
        }
        currentLine = word;
      }
    }
  }

  if (currentLine.isNotEmpty) {
    if (trimResult) {
      result.add(currentLine.trim());
    } else {
      result.add(currentLine);
    }
  }

  return result;
}
