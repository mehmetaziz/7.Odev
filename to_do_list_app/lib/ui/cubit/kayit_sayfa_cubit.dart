import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/data/repo/to_do_app_dao_repository.dart';

class KayitSayfaCubit extends Cubit<void> {
  KayitSayfaCubit() : super(0);
  var todoRepo = ToDoAppDaoRepository();
  Future<void> kayitEkle(String name) async {
    await todoRepo.kayitEkle(name);
  }
}
