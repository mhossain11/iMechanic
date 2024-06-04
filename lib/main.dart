import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imechanic/features/presentationLayer/pages/homepage/homepage.dart';

import 'features/data/repositiory/viewownpostrepositiory.dart';
import 'features/presentationLayer/bloc/viewownpostcubit/view_own_post_cubit.dart';
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
        /*BlocProvider(
          create: (context) => SubjectBloc(),
        ),*/
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

