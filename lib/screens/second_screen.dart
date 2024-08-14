// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'third_screen.dart';

class SecondScreen extends StatelessWidget {
  final String name;

  SecondScreen({required this.name});

  @override
  Widget build(BuildContext context) {
    final selectedUser = Provider.of<UserProvider>(context).selectedUser;
    return Scaffold(
      appBar: AppBar(title: Text('Second Screen')),
      body: Stack(
        children: [
          // Positioned text in the top-left corner
          Positioned(
            top: 10.0,
            left: 10.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome', style: TextStyle(fontSize: 19)),
                SizedBox(height: 5),
                Text('$name',
                    style:
                        TextStyle(fontSize: 29, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          // Centered text
          Center(
            child: Text(
              'Selected User Name: ${selectedUser?.firstName ?? 'None'} ${selectedUser?.lastName ?? ''}',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          // Button at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Center(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThirdScreen(),
                      ),
                    );
                  },
                  child: Text('Choose a User'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
