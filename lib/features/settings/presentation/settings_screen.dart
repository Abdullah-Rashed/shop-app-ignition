import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:gap/gap.dart';
import 'package:shop_app/app/app_cubit/cubit.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/common/constants/constants.dart';
import 'package:shop_app/common/services/router/app_router.dart';
import 'package:shop_app/common/services/shared_prefs/shared_prefs.dart';
import 'package:shop_app/features/auth/view/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockScreen = SharedPrefs.getBool(Constants.biometricsEnabledKey);
  final appCubit = serviceLocator<AppCubit>();
  @override
  Widget build(BuildContext context) {
    final appCubit = serviceLocator<AppCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () async {
              await appCubit.setLightMode();
              setState(() {});
            },
            leading: Icon(Icons.light_mode),
            tileColor: Colors.transparent,
            trailing: SharedPrefs.getString(Constants.themeModeKey) ==
                    ThemeEnums.light.name
                ? Icon(Icons.check)
                : SizedBox.shrink(),
            title: Text("Light Mode"),
          ),
          ListTile(
            onTap: () => setState(() {
              appCubit.setDarkMode();
            }),
            leading: Icon(Icons.dark_mode),
            tileColor: Colors.transparent,
            trailing: SharedPrefs.getString(Constants.themeModeKey) ==
                    ThemeEnums.dark.name
                ? Icon(Icons.check)
                : SizedBox.shrink(),
            title: Text("Dark Mode"),
          ),
          ListTile(
            onTap: () => setState(() {
              appCubit.setFollowSystem();
            }),
            leading: Icon(Icons.settings),
            tileColor: Colors.transparent,
            title: Text("Follow System"),
            trailing: SharedPrefs.getString(Constants.themeModeKey) ==
                    ThemeEnums.system.name
                ? Icon(Icons.check)
                : SizedBox.shrink(),
          ),
          Gap(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lock screen",
                        style: TextTheme.of(context).titleMedium,
                      ),
                      Text(
                        "Lock screen when the app is hidden and request pin or biometrics to start",
                        style: TextTheme.of(context).labelMedium?.copyWith(
                              color: Colors.grey,
                            ),
                      )
                    ],
                  ),
                ),
                Switch(
                  value: lockScreen,
                  onChanged: (value) async {
                    if (value == false) {
                      SharedPrefs.setBool(
                          Constants.biometricsEnabledKey, false);
                      setState(() {
                        lockScreen = value;
                      });
                    }
                    if (value == true) {
                      if (await appCubit.authenticateBiometrics() == true) {
                        SharedPrefs.setBool(
                            Constants.biometricsEnabledKey, true);
                        setState(() {
                          lockScreen = value;
                        });
                      }
                    }
                  },
                ),
              ],
            ),
          ),
          Gap(12),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            tileColor: Colors.transparent,
            title: Text("Log out"),
            onTap: () {
              SharedPrefs.setString("accessToken", "");
              AppRouter.pushReplace(screen: LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}
