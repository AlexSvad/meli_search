import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/items_repository.dart';
import '../../dependency_register.dart';
import '../../domain/entities/item_entity.dart';
import '../../l10n/l10n.dart';
import '../blocs/detail_bloc/detail_bloc.dart';
import '../blocs/detail_bloc/detail_event.dart';
import 'detail_screen.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    required this.results,
    super.key,
  });
  final List<ItemEntity> results;

  @override
  Widget build(BuildContext context) {
    final itemsRepository = Register.injector.get<ItemsRepository>();
    final l10n = context.l10n;
    if (results.isEmpty) {
      return Center(child: Text(l10n.resultsScreenErrorEmpty));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: CachedNetworkImage(
            imageUrl: item.thumbnailUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title: Text(item.title),
          subtitle: Text('\$${item.price}'),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => BlocProvider(
                  lazy: false,
                  create: (context) => DetailBloc(repository: itemsRepository)
                    ..add(LoadItemDetail(item.id)),
                  child: DetailScreen(itemId: item.id),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
