import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/ui/cubit/kayit_sayfa_cubit.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({super.key});

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfKontrol = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Ekle"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfKontrol,
                decoration: const InputDecoration(hintText: "Yapılacak"),
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<KayitSayfaCubit>().kayitEkle(tfKontrol.text);
                    
                  },
                  child: const Text("Kayıt Ekle"))
            ],
          ),
        ),
      ),
    );
  }
}
