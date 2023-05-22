import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poll_app/src/features/poll/presentation/cubits/poll/poll_cubit.dart';
import 'package:poll_app/src/features/poll/presentation/pages/accept_terms_page.dart';
import 'package:poll_app/src/config/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) => MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<PollCubit>(create: (_) => PollCubit()),
        ],
        child: child ?? Container(),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      home: const AcceptTermsPage(),
    );
  }
}
