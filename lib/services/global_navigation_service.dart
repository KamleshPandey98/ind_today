import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  pushNavigation(context, pageClassName, bool isMaterial){
    return isMaterial? Navigator.push(context,
        MaterialPageRoute(builder: (context) => pageClassName))
        :Navigator.push(context,
        CupertinoPageRoute(builder: (context) => pageClassName));
  }

  pushReplacementNavigation(context, pageClassName, bool isMaterial){
    return isMaterial? Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => pageClassName))
        :Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) => pageClassName));
  }

  pushAndRemoveUntilNavigation(context, pageClassName, bool isMaterial){
    return isMaterial ? Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
        builder: (context) => pageClassName), (route) => false)
        : Navigator.pushAndRemoveUntil(context,  CupertinoPageRoute(
        builder: (context) => pageClassName), (route) => false);
  }

  commonPopNavigation(context){
    return Navigator.of(context).pop();
  }
}

// locator<NavigationService>().navigateTo('login');