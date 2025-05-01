import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  final String userid, userName, userImage, userEmail;
  final Timestamp createdat;
  final List userCart, userWish;

  UserModel({
    required this.userid,
    required this.userName,
    required this.userImage,
    required this.userEmail,
    required this.createdat,
    required this.userCart,
    required this.userWish,
  });
}
