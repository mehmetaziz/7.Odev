import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeritabaniYardimcisi {
  //veritabanına erişim
  static const String veritabaniAdi = "todoapp.sqlite";
  static Future<Database> veritabaniErisim() async {
    String veriTabaniYolu = join(await getDatabasesPath(), veritabaniAdi);
    if (await databaseExists(veriTabaniYolu)) {
      print("Veritabanı mevcut");
    } else {
      ByteData data = await rootBundle.load("veritabani/$veritabaniAdi");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(veriTabaniYolu).writeAsBytes(bytes, flush: true);
      print("Veritabanı kopyalandı");
    }
    return openDatabase(veriTabaniYolu);
  }
}