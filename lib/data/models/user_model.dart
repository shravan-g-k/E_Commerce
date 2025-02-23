import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String id;
  final String email;
  final String? address;
  final List<String> likes;
  final List<String> cart;
  UserModel({
    required this.id,
    required this.email,
    this.address,
    required this.likes,
    required this.cart,
  });

  UserModel copyWith({
    String? id,
    String? email,
    ValueGetter<String?>? address,
    List<String>? likes,
    List<String>? cart,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      address: address != null ? address() : this.address,
      likes: likes ?? this.likes,
      cart: cart ?? this.cart,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'address': address,
      'likes': likes,
      'cart': cart,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      address: map['address'],
      likes: List<String>.from(map['likes']),
      cart: List<String>.from(map['cart']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, address: $address, likes: $likes, cart: $cart)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.id == id &&
      other.email == email &&
      other.address == address &&
      listEquals(other.likes, likes) &&
      listEquals(other.cart, cart);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      email.hashCode ^
      address.hashCode ^
      likes.hashCode ^
      cart.hashCode;
  }
}
