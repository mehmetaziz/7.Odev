import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/data/entity/to_do_app.dart';
import 'package:to_do_list_app/data/repo/to_do_app_dao_repository.dart';

class AnasayfaCubit extends Cubit<List<ToDoApp>> {
  AnasayfaCubit() : super(<ToDoApp>[]);
  var todoRepo = ToDoAppDaoRepository();

  Future<void> kayitSil(int id) async {
    await todoRepo.kayitSil(id);
    listeyiGetir();
  }

  Future<void> listeyiGetir() async {
    var liste = await todoRepo.listeyiGetir();
    emit(liste);
  }

  Future<void> listedeAra(String aramaKelimesi) async {
    var liste = await todoRepo.listeyiGetir();
    emit(liste);
  }
}
