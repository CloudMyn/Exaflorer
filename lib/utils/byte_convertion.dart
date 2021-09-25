import 'package:units_converter/DigitalData.dart';

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
    DigitalData dg = new DigitalData(significantFigures: 3);

    dg.convert(DIGITAL_DATA.byte, byte);

    return new ByteConvertion(
      value: dg.kilobyte.value ?? 0,
      symbValue: "${dg.kilobyte.stringValue}KB",
      symbol: dg.kilobyte.symbol ?? 'undifined',
    );
  }

  static ByteConvertion byteToMegabyte(double byte) {
    DigitalData dg = new DigitalData(significantFigures: 3);

    dg.convert(DIGITAL_DATA.byte, byte);

    return new ByteConvertion(
      value: dg.megabyte.value ?? 0,
      symbValue: "${dg.megabyte.stringValue}MB",
      symbol: dg.megabyte.symbol ?? 'undifined',
    );
  }

  static ByteConvertion byteToGigabyte(double byte) {
    DigitalData dg = new DigitalData(significantFigures: 3);

    dg.convert(DIGITAL_DATA.byte, byte);

    return new ByteConvertion(
      value: dg.gigabyte.value ?? 0,
      symbValue: "${dg.gigabyte.stringValue}GB",
      symbol: dg.gigabyte.symbol ?? 'undifined',
    );
  }

  static ByteConvertion byteToTerabyte(double byte) {
    DigitalData dg = new DigitalData(significantFigures: 3);

    dg.convert(DIGITAL_DATA.byte, byte);

    return new ByteConvertion(
      value: dg.terabyte.value ?? 0,
      symbValue: "${dg.terabyte.stringValue}GB",
      symbol: dg.terabyte.symbol ?? 'undifined',
    );
  }

  static ByteConvertion megabyteToGigabyte(double megabyte) {
    DigitalData dg = new DigitalData(significantFigures: 3);

    dg.convert(DIGITAL_DATA.megabyte, megabyte);

    return new ByteConvertion(
      value: dg.gigabyte.value ?? 0,
      symbValue: "${dg.gigabyte.stringValue}GB",
      symbol: dg.gigabyte.symbol ?? 'undifined',
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
