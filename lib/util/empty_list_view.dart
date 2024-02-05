import 'package:flutter/material.dart';

class EmptyListView extends StatelessWidget {
  final String title;
  final String? description;
  const EmptyListView({
    super.key,
    required this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                description!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
        ],
      ),
    );
  }
}
