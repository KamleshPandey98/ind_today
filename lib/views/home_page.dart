import 'package:flutter/material.dart';
import 'package:india_today/constants.dart';
import 'package:india_today/controllers/home_page_controller.dart';
import 'package:india_today/custom_styles.dart';
import 'package:india_today/models/dailyPanchangModel.dart';
import 'package:india_today/models/place_model.dart';
import 'package:india_today/reusable_methods.dart';
import 'package:india_today/reusable_widgets.dart';
import 'package:india_today/views/widgets/header.dart';
import 'package:india_today/views/widgets/panChang_widget.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomePageController _homePageController = HomePageController();
  final ReusableMethods _reusableMethods = ReusableMethods();
  var phnHeight;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    phnHeight = MediaQuery.of(context).size.height;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    awaitMethods();
  }

  awaitMethods() async {
    await _homePageController.fetchPlaces();
    // dPrint(_homePageController.locations[0].placeName);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          _homePageController.togglePlaceDropdown(show: false);
          _homePageController.unFocusAll();
        },
        child: Scaffold(
          appBar: const Header(),
          body: ListView(
            children: <Widget>[
              Row(
                children: const [
                  IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: CustomStyles.black,
                      )),
                  Text(
                    'Daily Panchang',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        "India isa country known for its festival but knowing "
                        "the exact dates can sometimes be difficult. To ensure "
                        "you do not miss outon the critical dates we bring you "
                        "the daily panchang"),
                    dateLocationBoxWidget(context),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PanChangWidget(reusableMethods: _reusableMethods,),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: CustomStyles.activeBtmNavIconColor,
            child: const Icon(
              Icons.menu,
              color: CustomStyles.mainParentWhiteColor,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  Widget dateLocationBoxWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      color: CustomStyles.dateLocContainer,
      // height: 180,
      child: Consumer<HomePageController>(builder: (context, provider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Date:"),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    readOnly: true,
                    controller: HomePageController.dateTxtController,
                    focusNode: HomePageController.dateTxtFocus,
                    decoration: inputDecoration(showSuffix: true),
                    onTap: () => _homePageController.pickDate(context),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Location:"),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    controller: HomePageController.locationTxtController,
                    focusNode: HomePageController.locationTxtFocus,
                    onTap: () {
                      provider.togglePlaceDropdown(show: false);
                    },
                    onSubmitted: (v) {
                      provider.fetchPlaces(initialHit: false);
                      provider.togglePlaceDropdown(show: true);
                    },
                    decoration: inputDecoration(showSuffix: false),
                    // onTap: ,
                  ),
                ),
              ],
            ),
            provider.places.isNotEmpty
                ? Center(child: locationDropDown(provider))
                : const SizedBox(),
          ],
        );
      }),
    );
  }

  Widget locationDropDown(HomePageController provider) {
    if (provider.showPlaceDropDown) {
      return Container(
        height: 180,
        margin: const EdgeInsets.only(left: 50),
        width: MediaQuery.of(context).size.width * 0.6,
        color: CustomStyles.mainParentWhiteColor,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: provider.places.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(provider.places[index].placeName),
              onTap: () {
                provider.togglePlaceDropdown(show: false);
                final place = provider.places[index];
                provider.setPlaceNameId(place.placeName, place.placeId);
                _homePageController.fetchPanChang();
              },
            );
          },
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  inputDecoration({bool? showSuffix}) {
    return InputDecoration(
      suffixIcon: showSuffix ?? false
          ? const Icon(
              Icons.arrow_drop_down,
              size: 28,
              color: CustomStyles.black,
            )
          : null,
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: CustomStyles.mainParentWhiteColor, width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: CustomStyles.mainParentWhiteColor, width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
      ),
      filled: true,
      fillColor: CustomStyles.mainParentWhiteColor,
    );
  }

}
