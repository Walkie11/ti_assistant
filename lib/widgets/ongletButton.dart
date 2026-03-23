import 'package:flutter/material.dart';
Widget ongletButton(VoidCallback onTap, String title, bool isSelected) {
  return Expanded(
                      child:GestureDetector(
                        onTap: onTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: title=="Inscription"? BorderRadius.horizontal(right: Radius.circular(10))
                            :BorderRadius.horizontal(left: Radius.circular(10)),
                            color: isSelected ? const Color.fromARGB(255, 192, 177, 154):const Color.fromARGB(255, 216, 131, 5) ,
                            boxShadow: isSelected ? []:[
                              BoxShadow(
                                color: const Color.fromARGB(92, 0, 0, 0),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              title,
                              style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    );
}