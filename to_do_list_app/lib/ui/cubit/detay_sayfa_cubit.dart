
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/data/repo/to_do_app_dao_repository.dart';

class DetaySayfaCubit extends Cubit<void> {
  DetaySayfaCubit() : super(0);
  var todoRepo = ToDoAppDaoRepository();

  Future<void> kayitGuncelle(int id, String name) async {
    await todoRepo.kayitGuncelle(id, name);
    
  }
}
