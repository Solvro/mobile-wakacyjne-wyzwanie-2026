import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../providers/dream_places_provider.dart";

class DeletePlaceDialog extends ConsumerStatefulWidget {
  final int placeId; // <-- dodany id

  const DeletePlaceDialog({super.key, required this.placeId});

  @override
  ConsumerState<DeletePlaceDialog> createState() => _DeletePlaceDialogState();
}

class _DeletePlaceDialogState extends ConsumerState<DeletePlaceDialog> {
  var _isDeleting = false;

  Future<void> _deleteDreamPlace() async {
    setState(() {
      _isDeleting = true;
    });

    try {
      final service = ref.read(dreamPlaceServiceProvider);
      await service.deleteDreamPlace(id: widget.placeId.toString());

      if (!mounted) return;
      Navigator.of(context).pop(true);
    } on Exception catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Nie udało się usunąć miejsca: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (!mounted) {
        setState(() {
          _isDeleting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        "Usuwanie miejsca",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      content: const Text(
        "Czy jesteś pewien, że chcesz usunąć swoje wymarzone miejsce?",
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: _isDeleting ? null : _deleteDreamPlace,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _isDeleting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text("Tak"),
        ),
        TextButton(
          onPressed: _isDeleting ? null : () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text("Nie"),
        ),
      ],
    );
  }
}
