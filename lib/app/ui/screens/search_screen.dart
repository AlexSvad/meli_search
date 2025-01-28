import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/l10n.dart';
import '../blocs/search_bloc/search_bloc.dart';
import '../blocs/search_bloc/search_event.dart';
import '../blocs/search_bloc/search_state.dart';
import 'results_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SearchBloc>();
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.searchScreenAppBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  onChanged: (value) {
                    bloc.add(SearchQueryChanged(value));
                  },
                  onSubmitted: (value) {
                    bloc.add(SearchSubmitted(value));
                  },
                  decoration: InputDecoration(
                    labelText: l10n.searchScreenInputLabel,
                    border: const OutlineInputBorder(),
                  ),
                ),
                if (state.status == SearchStatus.loading)
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: CircularProgressIndicator(),
                  ),
                if (state.status == SearchStatus.failure)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      state.errorMessage ?? l10n.searchScreenErrorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                if (state.status == SearchStatus.success)
                  Expanded(
                    child: ResultsScreen(
                      results: state.results,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
