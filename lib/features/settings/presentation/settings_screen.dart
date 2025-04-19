import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:gap/gap.dart';
import 'package:shop_app/app/app_cubit/cubit.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/common/constants/constants.dart';
import 'package:shop_app/common/services/shared_prefs/shared_prefs.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Log out"),
            onTap: () {
              SharedPrefs.setString("accessToken", "");
              Phoenix.rebirth(context);
            },
          )
        ],
      ),
    );
  }
}
