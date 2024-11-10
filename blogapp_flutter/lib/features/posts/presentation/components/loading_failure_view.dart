import 'package:blogapp_flutter/core/errors/failures.dart';
import 'package:flutter/material.dart';

class LoadingFailureView extends StatelessWidget {
  final VoidCallback onRetry;
  final String dataType;
  final Failure failure;

  const LoadingFailureView({
    super.key,
    required this.onRetry,
    required this.dataType,
    required this.failure,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: double.infinity * 0.8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Failed to load $dataType: ${failure.message}\nPlease try again later.',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
              ),
              child: const Text(
                'Retry',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
