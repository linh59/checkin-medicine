import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:checkin_medicine/features/search/presentation/providers/search_ai_medicine_privider.dart';

class EmptyState extends ConsumerWidget {
  final String title;
  final String query;

  const EmptyState({super.key, required this.title, required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;

    final aiState = ref.watch(medicineAIProvider(query));

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 48, color: color.onSurfaceVariant),

          const SizedBox(height: 12),

          Text(title, style: TextStyle(color: color.onSurfaceVariant)),

          const SizedBox(height: 16),

          Text(query),

          /// 🟡 CHỈ HIỂN THỊ KHI USER ĐÃ BẤM SEARCH AI
          if (aiState is AsyncLoading)
            const CircularProgressIndicator()
          else if (aiState is AsyncError)
            Text("Error: ${aiState.error}")
          else if (aiState is AsyncData)
            _buildAIResult(aiState.value!),

          const SizedBox(height: 20),

          /// 🔥 BUTTON = ONLY TRIGGER
          ElevatedButton(
            onPressed: () {
              ref.invalidate(medicineAIProvider(query)); // reset state
              ref.refresh(medicineAIProvider(query)); // trigger call
            },
            child: const Text("Search with AI"),
          ),
        ],
      ),
    );
  }

  Widget _buildAIResult(Map<String, dynamic> data) {
    final medicine = data['result']['medicine'];

    return Column(
      children: [
        Text("Brand: ${medicine['brand']}"),
        Text("Form: ${medicine['form']}"),
        Text("Summary: ${medicine['summary']}"),
      ],
    );
  }
}
