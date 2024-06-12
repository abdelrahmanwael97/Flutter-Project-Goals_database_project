import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_database_test_project/Cubit/Components/Goals_Lists.dart';
import 'Cubit/main_cubit.dart';

class Goals_Page extends StatelessWidget {
  Goals_Page({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()..initSql()..getData(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) { },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[900],
              title: const Center(
                  child: Text('GOALS',
                      style: TextStyle(
                          fontSize: 35,
                          letterSpacing: 6,
                          fontWeight: FontWeight.bold))),
            ),
            body: ListView.builder(
                itemCount: MainCubit.get(context).goalslist.length,
              itemBuilder:(context , index)=> goalItem(context,
                MainCubit.get(context).goalslist[index]['id'],
                MainCubit.get(context).goalslist[index]['name'],
                ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.teal,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          content: Container(
                            height: 180,
                            child: Column(
                              children: [
                                Container(
                                  height: 30,
                                  color: Colors.blue[900],
                                  child: const Center(
                                    child: Text('write your goals',
                                        style: TextStyle(
                                            color: Colors.white60,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Form(
                                  key: formKey,
                                  child: TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    controller: MainCubit.get(context).addTextController,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      filled: true,
                                      fillColor: Colors.white60,
                                      label: Text('WRITE HERE ...'),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            // Validate returns true if the form is valid, or false otherwise.
                                            if (formKey.currentState!.validate()) {
                                              MainCubit.get(context).insertData(
                                                MainCubit.get(context).addTextController.text.toString(),);
                                              MainCubit.get(context).addTextController.text = '';
                                              // TO MAKE TEXT FIELD BLANK AFTER TYPING
                                              MainCubit.get(context).getData();
                                              Navigator.pop(context);
                                            // If the form is valid, display a snackbar. In the real world,
                                            // you'd often call a server or save the information in a database.
                                            ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Processing Data')),
                                            );
                                            }

                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red[700])),
                                          child: const Text('ADD',
                                              style: TextStyle(
                                                  color: Colors.white60,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white60)),
                                          child: const Text('CANCEL',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ));
              },
              child: Icon(Icons.add, size: 35),
            ),
          );
        },
      ),
    );
  }
}
