import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/data/entity/to_do_app.dart';
import 'package:to_do_list_app/ui/cubit/detay_sayfa_cubit.dart';

// ignore: must_be_immutable
class DetaySayfa extends StatefulWidget {
  ToDoApp yapilacak;
  DetaySayfa({super.key, required this.yapilacak});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfKontrol = TextEditingController();
  @override
  void initState() {
    super.initState();
    var yapilacak = widget.yapilacak;
    tfKontrol.text = yapilacak.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detaylı Görünüm"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50,right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: tfKontrol,decoration: const InputDecoration(hintText: "Yapılacak"),),
              ElevatedButton(
                onPressed: ()=>
                context.read<DetaySayfaCubit>().kayitGuncelle(widget.yapilacak.id,tfKontrol.text), 
                child: const Text("Güncelle")),
            ],
          ),
        ),
      ),
    );
  }
}
