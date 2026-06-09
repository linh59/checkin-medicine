import 'package:checkin_medicine/core/services/medicine_ai_service.dart';

class SearchAIMedicineRepository {
  final MedicineAiService _service;

  SearchAIMedicineRepository(this._service);

  Future<Map<String, dynamic>> searchAIMedicine(String query) async {
    try {
      final aiResult = await _service.searchMedicine(query);

      return {"source": "ai", "data": aiResult};
    } catch (e) {
      throw Exception("AI search failed: $e");
    }
  }
}
