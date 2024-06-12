import 'package:flutter/material.dart';

import '../main_cubit.dart';

Widget goalItem (context, id, goalname) => InkWell(
  onTap: () {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          content: Container(
            height: 120,
            child: Column(
              children: [
                Container(
                  height: 30,
                  color: Colors.blue[900],
                  child: const Center(
                    child: Text('Editing',
                        style: TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            MainCubit.get(context).removeData(id);
                            MainCubit.get(context).getData();
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(
                                  Colors.red[700])),
                          child: const Text('REMOVE',
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
                ),
              ],
            ),
          ),
        ));
  },
  child:   Container(

        width: 400,

        height: 80,

        margin: const EdgeInsets.all(10),

        decoration: BoxDecoration(

          boxShadow: const [

            BoxShadow(color: Colors.black, blurRadius: 5, spreadRadius: 5)

          ],

          borderRadius: BorderRadius.circular(15),

          gradient: LinearGradient(

              begin: Alignment.bottomRight,

              colors: [Colors.blue[900]!, Colors.blue]),

        ),

        child: Center(

          child: Text('$id : $goalname',

              style: const TextStyle(

                  fontSize: 35, letterSpacing: 6, fontWeight: FontWeight.bold)),

        ),

      ),
);
