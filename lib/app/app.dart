import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/themes/app_theme.dart';
import 'data/repositories/items_repository.dart';
import 'dependency_register.dart';
import 'l10n/l10n.dart';
import 'ui/blocs/search_bloc/search_bloc.dart';
import 'ui/screens/search_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final itemsRepository = Register.injector.get<ItemsRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SearchBloc(repository: itemsRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: const ScrollBehavior().copyWith(
          physics: const BouncingScrollPhysics(
            parent: RangeMaintainingScrollPhysics(),
          ),
        ),
        theme: AppTheme.light,
        color: Colors.transparent,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SearchScreen(),
      ),
    );
  }
}
