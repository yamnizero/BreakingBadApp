import 'package:breaking/router/router_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( BreakingBadApp(appRouter: AppRouter(),));
}

class BreakingBadApp extends StatelessWidget {
   final AppRouter appRouter;
  const BreakingBadApp({Key? key,required this.appRouter}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRouter,
    );
  }
}
