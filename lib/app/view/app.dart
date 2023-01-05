import 'package:ala_mod/app/bloc/app_bloc.dart';
import 'package:ala_mod/article_builder/view/article_add_page.dart';
import 'package:ala_mod/articles/view/article_page.dart';
import 'package:ala_mod/counter/counter.dart';
import 'package:ala_mod/homepage/view/home_page.dart';
import 'package:ala_mod/l10n/l10n.dart';
import 'package:ala_mod/login/view/view.dart';
import 'package:ala_mod/register/view/view.dart';
import 'package:ala_mod/splash/splash.dart';
import 'package:articles_repository/articles_repository.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_repository/posts_repository.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required AuthRepository authRepository,
    required PostsRepository postsRepository,
    required ArticlesRepository articlesRepository,
  })  : _authRepository = authRepository,
        _postsRepository = postsRepository,
        _articlesRepository = articlesRepository;

  final AuthRepository _authRepository;
  final PostsRepository _postsRepository;
  final ArticlesRepository _articlesRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authRepository),
        RepositoryProvider.value(value: _postsRepository),
        RepositoryProvider.value(value: _articlesRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppBloc(
              authRepository: _authRepository,
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

const _brandBlue = Color(0xFF1E88E5);

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;

      if (lightDynamic != null && darkDynamic != null) {
        lightColorScheme = lightDynamic.harmonized();
        lightColorScheme = lightColorScheme.copyWith(secondary: _brandBlue);

        darkColorScheme = darkDynamic.harmonized();
        darkColorScheme = darkColorScheme.copyWith(secondary: _brandBlue);
      } else {
        lightColorScheme = ColorScheme.fromSeed(
          seedColor: _brandBlue,
        );
        darkColorScheme = ColorScheme.fromSeed(
          seedColor: _brandBlue,
          brightness: Brightness.dark,
        );
      }

      return MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'Ala',
        theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: lightColorScheme,
          scaffoldBackgroundColor: const Color(0xFFE7E7E7),
        ),
        darkTheme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: darkColorScheme,
          scaffoldBackgroundColor: const Color(0xFFE7E7E7),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routes: {
          '/counter': (_) => const CounterPage(),
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/splash': (_) => const SplashPage(),
          '/home': (_) => const HomePage(),
          ArticlePage.routeName: (context) => ArticlePage(
                ModalRoute.of(context)!.settings.arguments! as Article,
              ),
          ArticleAddPage.routeName: (_) => const ArticleAddPage(),
        },
        builder: (context, child) {
          return BlocListener<AppBloc, AppState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  _navigator.pushAndRemoveUntil(
                    HomePage.route(),
                    (route) => false,
                  );
                  break;
                case AuthenticationStatus.unauthenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    LoginPage.route(),
                    (route) => false,
                  );
                  break;
                case AuthenticationStatus.unknown:
                  break;
              }
            },
            child: child,
          );
        },
        onGenerateRoute: (_) => SplashPage.route(),
      );
    });
  }
}
