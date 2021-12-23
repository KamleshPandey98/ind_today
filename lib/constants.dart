import 'package:india_today/services/platform_checker.dart';

dPrint(text){
  if(!PlatformCheck.isInReleaseMode()){
    try{
      print(text);
    }catch(e){
      print(e);
    }
  }
}