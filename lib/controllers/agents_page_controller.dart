

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:india_today/controllers/all_json_parsing.dart';
import 'package:india_today/models/all_agents_model.dart';

import '../constants.dart';

class AgentsPageController extends ChangeNotifier{

  static final AgentsPageController _homePageController = AgentsPageController._internal();
  factory AgentsPageController() {
    return _homePageController;
  }
  AgentsPageController._internal();

  // Text Controllers
  static final TextEditingController searchTxtController = TextEditingController();

  // Focus Node
  static final FocusNode searchTxtFocus = FocusNode();

  List<AllAgents> _allAgentsList = [];
  List<AllAgents> _filterAgentsList = [];
  // String _selectedSortItem = "";
  final _sortList = ['Experience- high to low', 'Experience- low to high', "Price- high to low", "Price- low to high"];
  final ValueNotifier<String> _selectedSortItem = ValueNotifier<String>("");
  var _showSearchBar = false;



  Future<void> fetchAllAgents()async{
    dPrint("inn");

    await AllParsings.allAgentsGetApi().then((value){
      if(value!=null){
        if(value.isNotEmpty){
          setAllAgents(allAgentsFromJson(value));
        }
      }
    });
  }

  // SETTERS
  setAllAgents(List<AllAgents> agents){
    _allAgentsList = agents;
    _filterAgentsList = _allAgentsList;
    // dPrint(_allAgentsList);
    notifyListeners();
  }

  setFilterAgentsList(String query){
  var sortObject = "";
  var orderBy = "asc";
    switch(_selectedSortItem.value){
      case "Experience- high to low":
        orderBy = "desc";
        sortObject = "exp";
        break;
      case "Experience- low to high":
        orderBy = "asc";
        sortObject = "exp";
        break;
      case "Price- high to low":
        orderBy = "desc";
        sortObject = "price";
        break;
      case "Price- low to high":
        orderBy = "asc";
        sortObject = "price";
        break;
      default:
        orderBy = "asc";
    }
    _filterAgentsList = _allAgentsList.where((element){
      return(
          (element.firstName.toLowerCase()+" "+element.lastName.toLowerCase()).contains(query.toLowerCase(), 1) ||
              element.experience.toLowerCase().contains(query.toLowerCase())
      );
    }).toList();

    if(sortObject == "exp"){
      if(orderBy=="asc"){
        _filterAgentsList.sort((AllAgents a, AllAgents b) => double.parse(a.experience).compareTo(double.parse(b.experience)));
      }else{
        _filterAgentsList.sort((AllAgents a, AllAgents b) => -double.parse(a.experience).compareTo(double.parse(b.experience)));
      }
    }else{
      if(orderBy=="asc"){
        _filterAgentsList.sort((AllAgents a, AllAgents b) => a.additionalPerMinuteCharges.compareTo(b.additionalPerMinuteCharges));
      }else{
        _filterAgentsList.sort((AllAgents a, AllAgents b) => -a.additionalPerMinuteCharges.compareTo(b.additionalPerMinuteCharges));
      }
    }


    notifyListeners();
  }

  setRadioItem(val){
    _selectedSortItem.value = "$val";
    setFilterAgentsList(searchTxtController.text);
    dPrint(val);
    notifyListeners();
  }

  toggleSearchBar(){
    _showSearchBar = !showSearchBar;
    searchTxtController.clear();
    setFilterAgentsList("");
    notifyListeners();
  }

  //GETTERS
  List<AllAgents> get allAgentsList => _allAgentsList;
  List<AllAgents> get filterAgentsList => _filterAgentsList;
  List<String> get sortList => _sortList;
  ValueNotifier<String> get selectedSortItem => _selectedSortItem;
  bool get showSearchBar => _showSearchBar;
}