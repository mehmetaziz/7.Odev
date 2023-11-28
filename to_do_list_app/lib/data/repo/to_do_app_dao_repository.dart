import 'package:to_do_list_app/data/entity/to_do_app.dart';
import 'package:to_do_list_app/sqlite/veritabani_yardimcisi.dart';

class ToDoAppDaoRepository {
  Future<void> kayitEkle(String name) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var kayit = <String, dynamic>{}; //literal'a çevrilmesi öneriliyor
    kayit["name"] = name;
    await db.insert("toDos", kayit);
  }

  Future<void> kayitGuncelle(int id, String name) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var guncellenecekKayit = <String, dynamic>{};
    guncellenecekKayit["name"] = name;
    await db.update("toDos", guncellenecekKayit, 
    where: "id = ?", whereArgs: [id]);
  }

  Future<void> kayitSil(
    int id,
  ) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("toDos", where: "id = ?", whereArgs: [id]);
  }

  Future<List<ToDoApp>> listeyiGetir() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> satirlar = await db.query("toDos");
    return List.generate(satirlar.length, (index) {
      var satir = satirlar[index];
      var id = satir["id"];
      var name = satir["name"];
     return ToDoApp(id: id, name: name);
    });
  }
  Future<List<ToDoApp>> listedeAra(String aramaKelimesi) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> satirlar = 
    await db.rawQuery("SELECT * FROM toDos WHERE name like '%$aramaKelimesi%'");
    return List.generate(satirlar.length, (index) {
      var satir = satirlar[index];
      var id = satir["id"];
      var name = satir["name"];
      
     return ToDoApp(id: id, name: name);
    });
  }
}
