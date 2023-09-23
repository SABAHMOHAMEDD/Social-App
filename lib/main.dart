import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc.dart';
import 'package:social_app/core/core.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'firebase_options.dart';
import 'modules/Home/layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();
  final String? uId = CacheHelper.getData(key: 'uId');
  print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
  print(uId);
  print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");

  Widget widget;
  if (uId != null) {
    widget = Layout();
  } else {
    widget = LoginScreen();
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return GenerateMultiBloc(
      child: MaterialApp(
        color: KPrimaryColor,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.LightTheme,
        darkTheme: AppTheme.DarkTheme,
        themeMode: ThemeMode.light,
        routes: AppRoutes,
        home: startWidget,
      ),
    );
  }
}
