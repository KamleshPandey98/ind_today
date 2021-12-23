
import 'dart:convert';
import 'package:india_today/controllers/home_page_controller.dart';
import 'package:india_today/models/all_urls.dart';
import 'package:http/http.dart' as http;
import 'package:india_today/reusable_methods.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class AllParsings{
  // static final _reusableMethods = ReusableMethods();
  // final _homePageController = HomePageController();

  static Future placesGetApi(String loc) async {
    try {
      final response = await http.get(
          Uri.parse("${AllUrls.location}=$loc"),
          headers: {"Content-Type": "application/json"},
      );
      final result = jsonDecode(response.body);
      if(result["success"]){
        return result["data"];
      }
      return [];
    } catch (e) {
      dPrint(e);
      return null;
    }
  }

  static Future getPanChang(date, placeId) async{
    // if(date==null || HomePageController().selectedPlaceId!="") return ;
    // final body = jsonEncode({
    //   "day":  HomePageController().date?.day,
    //   "month":HomePageController().date?.month,
    //   "year": HomePageController().date?.year,
    //   "placeId": HomePageController().selectedPlaceId
    // });
    final body = jsonEncode({
      "day":  date?.day,
      "month": date?.month,
      "year": date?.year,
      "placeId": placeId
    });
    try {
      final response = await http.post(
        Uri.parse(AllUrls.panchang),
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      final result = jsonDecode(response.body);
      if(result["success"]){
        return result["data"];
      }
      return {};
    } catch (e) {
      dPrint(e);
      return null;
    }
  }

  static Future allAgentsGetApi() async {
    try {
      final response = await http.get(
        Uri.parse(AllUrls.allAgents),
        headers: {"Content-Type": "application/json"},
      );
      final result = jsonDecode(response.body);
      if(result["success"]){
        return result["data"];
      }
      return [];
    } catch (e) {
      dPrint(e);
      return null;
    }
  }

}