import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/app/ignition_shop.dart';
import 'package:shop_app/common/services/bloc_observer/bloc_observer.dart';

void main() async {
  await initDependencies();
  Bloc.observer = TBlocObserver();
  runApp(const IgnitionShop());
}
