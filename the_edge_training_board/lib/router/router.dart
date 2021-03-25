import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:the_edge_training_board/pages.dart';

class Fluro {
  static FluroRouter router = FluroRouter();
  // static Handler _productHandler = Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  //       final args = context.settings.arguments as Product;
  //       return ProductPage(id: params['id'][0], product: args);
  //     });
  static Handler _homeHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          HomePage());
  static Handler _settingsHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          SettingsPage());
  static Handler _addRouteHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          AddRoutePage());
  static Handler _myRoutesHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          MyRoutesPage());
  // static fluro.Handler _orderhandler = fluro.Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  //       final args = context.settings.arguments as Order;
  //       return OrderPage(id: params['id'][0], order: args);
  //     });
  // static fluro.Handler _analyticshandler = fluro.Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
  //         AnalyticsPage());
  // static fluro.Handler _accountHandler = fluro.Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
  //         AccountPage());
  static void setupRouter() {
    router.define(
      '/',
      handler: _homeHandler,
    );
    router.define(
      '/settings',
      handler: _settingsHandler,
    );
    router.define(
      '/add_route',
      handler: _addRouteHandler,
    );
    router.define(
      '/my_routes',
      handler: _myRoutesHandler,
    );
    // router.define(
    //   '/products/:id',
    //   handler: _productHandler,
    // );
    // router.define(
    //   '/orders',
    //   handler: _ordershandler,
    // );
    // router.define(
    //   '/orders/:id',
    //   handler: _orderhandler,
    // );
    // router.define(
    //   '/analytics',
    //   handler: _analyticshandler,
    // );
    // router.define(
    //   '/account',
    //   handler: _accountHandler,
    // );
    // router.define(
    //   '/product/:name',
    //   handler: _productHandler,
    // );
  }
}
