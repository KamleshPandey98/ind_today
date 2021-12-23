import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:india_today/controllers/all_json_parsing.dart';
import 'package:india_today/models/all_agents_model.dart';
import 'package:india_today/models/dailyPanchangModel.dart';
import 'package:india_today/models/place_model.dart';
import 'package:intl/intl.dart';

class HomePageController extends ChangeNotifier{

  static final HomePageController _homePageController = HomePageController._internal();
  factory HomePageController() {
    return _homePageController;
  }
  HomePageController._internal();

  // Text Controllers
  static final TextEditingController dateTxtController = TextEditingController();
  static final TextEditingController locationTxtController = TextEditingController();

  // Focus Node
  static final FocusNode dateTxtFocus = FocusNode();
  static final FocusNode locationTxtFocus = FocusNode();


  // Page Controllers
  List<Place> _places = [];
  String _selectedPlace = "";
  String _selectedPlaceId = "";
  static DateTime? _date;
  bool _showPlaceDropDown = false;

  PanChang? _panChangList;



  // Others

  unFocusAll(){
    dateTxtFocus.unfocus();
    locationTxtFocus.unfocus();
  }

  Future pickDate(context) async {
    final initialDate = DateTime.now();
    final _newDate = await showDatePicker(
      context: context,
      initialDate: _date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );

    if (_newDate == null) return;
    _date = _newDate;
    getPickedDate();
  }

  String getPickedDate() {
    if (_date == null) {
      return dateTxtController.text = 'Select Date';
    } else {
      // MMMMEEEE
      fetchPanChang();
      return dateTxtController.text = "${_date!.day}th ${DateFormat.LLLL().format(_date!)}, ${_date!.year}";
      // return dateTxtController.text = DateFormat.MMMMEEEEd().format(_date!);
    }
  }

  fetchPlaces({initialHit})async{
    await AllParsings.placesGetApi(locationTxtController.text).then((value){
      if(value!=null){
        if(value.isNotEmpty){
          // _locations = ;
          setPlaces(placeFromJson(value));
          if(initialHit==false){
            togglePlaceDropdown(show: true);
          }
          print(_places);
        }
      }
    });
  }

  fetchPanChang()async{
    if(_date==null || _selectedPlaceId=="") return;
    print("inn");

    await AllParsings.getPanChang(date, selectedPlaceId).then((value){
      if(value!=null){
        if(value.isNotEmpty){
          setPanChang(panChangFromJson(value));
        }
      }
    });
  }

  // SETTERS
  setPlaces(value){
    _places = value;
    notifyListeners();
  }

  setPanChang(value){
    _panChangList = value;
    notifyListeners();
  }

  togglePlaceDropdown({show}){
    if(places.isNotEmpty){
      _showPlaceDropDown = show;
    }else{
      _showPlaceDropDown = show;
    }
    notifyListeners();
  }

  setPlaceNameId(name, id){
    locationTxtController.text = name;
    _selectedPlace = name;
    _selectedPlaceId = id;
    notifyListeners();
  }


  // GETTERS
  List<Place> get places => _places;
  String get selectedPlace => _selectedPlace;
  String get selectedPlaceId => _selectedPlaceId;
  bool get showPlaceDropDown => _showPlaceDropDown;
  DateTime? get date => _date;

  PanChang? get panChangList => _panChangList;
}