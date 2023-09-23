import 'package:social_app/core/core.dart';

import '../../core/utils/constants.dart';

class SettingScreen extends StatelessWidget {
  static const String RouteName = 'Settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                SignOut(context);
              },
              icon: Icon(
                Icons.exit_to_app,
                size: 45,
                color: KPrimaryColor.withOpacity(0.8),
              ),
            ),
            Text(
              'Sign Out',
              style: TextStyle(color: KPrimaryColor.withOpacity(.8)),
            ),
          ],
        ),
      ),
    );
  }
}
