import 'package:checkin_medicine/features/auth/presentation/providers/profile_provider.dart';
import 'package:checkin_medicine/features/timelines/presentation/pages/timeline_detail_page.dart';
import 'package:checkin_medicine/features/timelines/presentation/providers/timeline_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateTimelineDialog extends ConsumerStatefulWidget {
  const CreateTimelineDialog({super.key});

  @override
  ConsumerState<CreateTimelineDialog> createState() =>
      _CreateTimelineDialogState();
}

class _CreateTimelineDialogState extends ConsumerState<CreateTimelineDialog> {
  final _controller = TextEditingController();

  bool loading = false;

  Future<void> _create() async {
    final profileState = ref.watch(profileProvider);

    final profileId = profileState.profile?.id;

    if (profileId == null) {
      return;
    }

    setState(() => loading = true);

    try {
      final repo = ref.read(timelineRepositoryProvider);

      final planId = await repo.createPlan(
        profileId: profileId,
        name: _controller.text.trim(),
      );

      if (!mounted) return;

      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TimelineDetailPage(timelineId: planId),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final canCreate = _controller.text.trim().isNotEmpty && !loading;
    return AlertDialog(
      title: const Text('Create Timeline'),

      content: TextField(
        controller: _controller,
        onChanged: (_) => setState(() {}),
        decoration: const InputDecoration(hintText: 'Timeline name'),
      ),
      actions: [
        ElevatedButton(
          onPressed: canCreate ? _create : null,
          child: loading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Create'),
        ),
      ],
    );
  }
}
