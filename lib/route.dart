import 'package:flutter/cupertino.dart';
import 'package:flutter_with_db/detail.dart';
import 'package:flutter_with_db/form_example.dart';
import 'package:flutter_with_db/home_page.dart';

final Map<String, WidgetBuilder> routes = {
  FormExample.routeName: (context) => FormExample(),
  Detail.routeName: (context) => Detail(),
};
