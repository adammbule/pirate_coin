import 'dart:convert';

import 'package:Piratecoin/features/auth/domain/entities/user.dart';
import 'package:dio/dio.dart';
import 'package:Piratecoin/services/storage/secure_storage.dart';
import 'package:flutter/material.dart';

class AuthRemoteDataSource {
  final Dio dio;
  final SecureStorage storage;

  AuthRemoteDataSource({
    required this.dio,
    required this.storage,
  });

  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post(
        "https://piratenode.onrender.com/api/users/login",
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        final user = User.fromJson(data);

        final token = user.token ?? '';
        final userid = user.userid ?? '';
        final username = user.username ?? '';

        //debugPrint("Login response (User): ${user.username}, ${user.userid}");

        // Save only the essentials
        await storage.saveToken(token);
        await storage.saveUsername(username);
        await storage.saveUserid(userid);

        return user;
      } else {
        throw Exception("Login failed: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Login error: ${e.message}");
    }
  }

  Future<void> logout() async {
    await storage.clearToken();
  }

  Future<String?> getSavedToken() async {
    return await storage.getToken();
  }
}
