import 'package:flutter/foundation.dart';

@visibleForTesting
abstract final class LoremIpsum {
  const LoremIpsum._();

  /// A 27-character Lorem Ipsum string.
  ///
  /// For short labels, titles, and single-word or phrase-level inputs.
  static const tiny = 'Lorem ipsum dolor sit amet.';

  /// A 106-character Lorem Ipsum string.
  ///
  /// For single-line messages, hint texts, and validation error messages.
  static const short =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
      ' Aenean vel iaculis ante, malesuada semper mauris.';

  /// A 314-character Lorem Ipsum string.
  ///
  /// For multi-line descriptions, callout messages, and body text that spans
  /// two to three lines.
  static const medium =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
      ' Aenean vel iaculis ante, malesuada semper mauris. Nunc a faucibus elit.'
      ' Sed sagittis sapien ullamcorper, vehicula metus quis, porttitor dolor.'
      ' Etiam ullamcorper ornare orci nec faucibus.'
      ' Nulla dolor ligula, bibendum id massa vitae, blandit scelerisque nunc.';

  /// A 1043-character Lorem Ipsum string.
  ///
  /// For scrollable content, text area, and long-form body text where overflow
  /// or scroll behavior needs to be verified.
  static const long =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
      ' Aenean vel iaculis ante, malesuada semper mauris. Nunc a faucibus elit.'
      ' Sed sagittis sapien ullamcorper, vehicula metus quis, porttitor dolor.'
      ' Etiam ullamcorper ornare orci nec faucibus.'
      ' Nulla dolor ligula, bibendum id massa vitae, blandit scelerisque nunc.'
      ' Mauris vitae ante non nisi scelerisque imperdiet vitae fringilla ipsum.'
      ' In ligula augue, egestas sed ipsum ut, finibus mattis enim.'
      ' Nam ante sem, viverra sed interdum sed, suscipit sed ante.'
      ' Suspendisse mauris eros, placerat id tristique ut, efficitur ac metus.'
      ' Aenean ac augue convallis mauris egestas semper.'
      ' Integer bibendum sollicitudin pharetra. In quis pretium nunc.'
      ' Interdum et malesuada fames ac ante ipsum primis in faucibus.'
      ' Donec lorem quam, varius id felis a, dictum eleifend turpis.'
      ' Proin dapibus vel velit id lobortis.'
      ' Donec sit amet dui non odio sodales faucibus.'
      ' Nullam egestas sollicitudin ante vitae vestibulum.'
      ' In congue, ante eu tristique aliquam, ligula sem lacinia arcu,'
      ' a pellentesque nunc lorem sed odio.';
}
