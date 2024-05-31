import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_fm/ui/home/home_screen.dart';

import 'bloc/album_bloc.dart';
import 'bloc/search/search_bloc.dart';
import 'config/navigation/app_router.dart';
import 'config/values/colors.dart';
import 'data/repositories/album_repository.dart';
import 'data/repositories/search_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [
        Locale("en", "US"),
      ],
      path: 'assets/languages',
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchBloc(
            searchRepository: SearchRepositoryImpl(),
          ),
        ),
        BlocProvider(
          create: (context) => AlbumBloc(
            repository: AlbumRepositoryImpl(),
          ),
        ),
      ],
      child: MaterialApp(
        title: "LastFM App",
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: HomeScreen(),
        theme: ThemeData(
          primaryColor: primaryColor,
          appBarTheme: AppBarTheme(
            color: primaryColor,
          ),
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
        initialRoute: rootPath,
      ),
    );
  }

  @override
  void dispose() {
    _appRouter.dispose();
  }
}
