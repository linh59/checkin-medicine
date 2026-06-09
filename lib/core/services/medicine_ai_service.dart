import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';

class MedicineAiService {
  final _supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> searchMedicine(String query) async {
    final res = await _supabase.functions.invoke(
      'quick-handler',
      body: {"query": query},
    );

    if (res.data == null) {
      throw Exception("AI response is null");
    }

    final rawResult = res.data['result'];

    if (rawResult == null) {
      throw Exception("Missing result from AI");
    }

    final decoded = jsonDecode(rawResult);

    if (decoded is! Map<String, dynamic>) {
      throw Exception("Invalid AI result format");
    }


    return decoded;
  }
}
