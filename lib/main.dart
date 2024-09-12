import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme/themes.dart';
import 'features/data/repositiory/viewownpostrepositiory.dart';
import 'features/presentationLayer/cubit/viewownpostcubit/view_own_post_cubit.dart';
import 'features/presentationLayer/pages/splashscreen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ViewOwnPostCubit(ViewOwnPostRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: appTheme,
        home: const SplashScreen(),
      ),
    );
  }
}

