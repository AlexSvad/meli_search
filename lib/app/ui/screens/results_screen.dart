import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/item_entity.dart';
import '../../l10n/l10n.dart';
import 'detail_screen.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    required this.results,
    super.key,
  });
  final List<ItemEntity> results;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (results.isEmpty) {
      return Center(child: Text(l10n.resultsScreenErrorEmpty));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: Image.network(
            item.thumbnailUrl ?? '',
            width: 50,
            height: 50,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          ),
          title: Text(item.title ?? ''),
          subtitle: Text('\$${item.price}'),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => DetailScreen(itemId: item.id),
              ),
            );
          },
        );
      },
    );
  }
}
