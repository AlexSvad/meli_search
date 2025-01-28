import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/items_repository.dart';
import '../../dependency_register.dart';
import '../../l10n/l10n.dart';
import '../blocs/detail_bloc/detail_bloc.dart';
import '../blocs/detail_bloc/detail_event.dart';
import '../blocs/detail_bloc/detail_state.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({required this.itemId, super.key});
  final String itemId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final itemsRepository = Register.injector.get<ItemsRepository>();
    return BlocProvider(
      lazy: false,
      create: (context) =>
          DetailBloc(repository: itemsRepository)..add(LoadItemDetail(itemId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.detailScreenAppBarTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state.status == DetailStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == DetailStatus.failure) {
              return Center(
                child: Text(
                  state.errorMessage ?? l10n.detailScreenError,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state.status == DetailStatus.success &&
                state.item != null) {
              final item = state.item!;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.network(
                      item.thumbnailUrl ?? '',
                      height: 200,
                      errorBuilder: (_, __, ___) => const Icon(Icons.error),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      item.title ?? '',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${item.price}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${l10n.detailScreenQuantityAvailable}: ${item.availableQuantity}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
