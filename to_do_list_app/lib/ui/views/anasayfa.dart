import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/data/entity/to_do_app.dart';
import 'package:to_do_list_app/ui/cubit/anasayfa_cubit.dart';
import 'package:to_do_list_app/ui/views/detay_sayfa.dart';
import 'package:to_do_list_app/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool arama = false;
  bool checkboxKontrol = false;
  var tfKontrol = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().listeyiGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: arama
            ? TextField(
                controller: tfKontrol,
                decoration: const InputDecoration(hintText: "Ara"),
                onChanged: (sonuc) {
                  
                  context.read<AnasayfaCubit>().listedeAra(sonuc);
                },
              )
            : const Text("Yapılacaklar"),
        actions: [
          arama
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      arama = false;
                    });
                    context.read<AnasayfaCubit>().listeyiGetir();
                  },
                  icon: const Icon(Icons.clear),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      arama = true;
                    });
                  },
                  icon: const Icon(Icons.search),
                )
        ],
      ),
      body: BlocBuilder<AnasayfaCubit, List<ToDoApp>>(
        builder: (context, todolist) {
          if (todolist.isNotEmpty) {
            return ListView.builder(
              itemCount: todolist.length,
              itemBuilder: (context, index) {
                var yapilacak = todolist[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetaySayfa(
                                yapilacak: yapilacak,
                              ),
                            ))
                        .then((value) =>
                            context.read<AnasayfaCubit>().listeyiGetir());
                  },
                  child: Card(
                    child: SizedBox(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              yapilacak.name,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Checkbox(
                              value: checkboxKontrol,
                              onChanged: (value) {
                                checkboxKontrol = value!;
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text("Silinsin mi?"),
                                  action: SnackBarAction(
                                    label: "Evet",
                                    onPressed: () {
                                      context
                                          .read<AnasayfaCubit>()
                                          .kayitSil(yapilacak.id);
                                      checkboxKontrol = false;
                                    },
                                  ),
                                ));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const KayitSayfa()))
              .then((value) => context.read<AnasayfaCubit>().listeyiGetir());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
