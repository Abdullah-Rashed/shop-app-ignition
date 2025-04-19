import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/app/ignition_shop.dart';
import 'package:shop_app/common/services/bloc_observer/bloc_observer.dart';
import 'package:shop_app/common/services/shared_prefs/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  Bloc.observer = TBlocObserver();
  await SharedPrefs.initialize();
  runApp(
    Phoenix(
      child: const IgnitionShop(),
    ),
  );
}
