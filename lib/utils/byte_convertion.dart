import 'package:units_converter/units_converter.dart';

/// ByteConvertion merupakan class yang
/// menyediakan metode/fungsi untuk mengubah
/// nila berformat byte menjadi beberapa tipe
/// seperti, kilobyte, megabyte, gigabyte, dll...
class ByteConvertion {
  final String symbValue, symbol;
  final double value;

  const ByteConvertion({
    required this.symbValue,
    required this.value,
    required this.symbol,
  });

  static ByteConvertion byteToKilobyte(double byte) {
    var convertedValue =
        byte.convertFromTo(DIGITAL_DATA.byte, DIGITAL_DATA.kilobyte);
    return new ByteConvertion(
      value: convertedValue ?? 0,
      symbValue: "${convertedValue}KB",
      symbol: 'KB',
    );
  }

  static ByteConvertion byteToMegabyte(double byte) {
    var convertedValue =
        byte.convertFromTo(DIGITAL_DATA.byte, DIGITAL_DATA.megabyte);
    return new ByteConvertion(
      value: convertedValue ?? 0,
      symbValue: "${convertedValue}MB",
      symbol: 'MB',
    );
  }

  static ByteConvertion byteToGigabyte(double byte) {
    var convertedValue =
        byte.convertFromTo(DIGITAL_DATA.byte, DIGITAL_DATA.gigabyte);
    return new ByteConvertion(
      value: convertedValue ?? 0,
      symbValue: "${convertedValue}GB",
      symbol: 'GB',
    );
  }

  static ByteConvertion byteToTerabyte(double byte) {
    var convertedValue =
        byte.convertFromTo(DIGITAL_DATA.byte, DIGITAL_DATA.terabyte);
    return new ByteConvertion(
      value: convertedValue ?? 0,
      symbValue: "${convertedValue}TB",
      symbol: 'TB',
    );
  }

  static ByteConvertion megabyteToGigabyte(double megabyte) {
    var convertedValue =
        megabyte.convertFromTo(DIGITAL_DATA.megabyte, DIGITAL_DATA.gigabyte);
    return new ByteConvertion(
      value: convertedValue ?? 0,
      symbValue: "${convertedValue}GB",
      symbol: 'GB',
    );

    // ...
  }

  static ByteConvertion upConvert(double byte) {
    // note:
    // 1kb = 1000 byte
    // 1mb = 1000000 byte
    // 1gb = 1000000000 byte
    // 1tb = 1000000000000 byte

    late ByteConvertion bc;

    if (byte >= 1000000000000) {
      bc = byteToTerabyte(byte);
    } else if (byte >= 1000000000 && byte < 1000000000000) {
      bc = byteToGigabyte(byte);
    } else if (byte >= 1000000 && byte < 1000000000) {
      bc = byteToMegabyte(byte);
    } else {
      bc = byteToKilobyte(byte);
    }

    return bc;

    // ...
  }

  // ...
}
