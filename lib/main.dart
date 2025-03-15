import 'package:flutter/material.dart';
import 'package:shop_app/app/get_it/get_it.dart';
import 'package:shop_app/app/ignition_shop.dart';

void main() async {
  await initDependencies();
  runApp(const IgnitionShop());
}
