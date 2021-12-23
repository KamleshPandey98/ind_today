import 'package:flutter/material.dart';
import 'package:india_today/controllers/home_page_controller.dart';
import 'package:provider/provider.dart';

import '../../custom_styles.dart';
import '../../reusable_methods.dart';

class PanChangWidget extends StatelessWidget {
  const PanChangWidget({
    required this.reusableMethods,
    Key? key,
  }) : super(key: key);

  final ReusableMethods reusableMethods;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageController>(builder: (context, provider, child) {
      return provider.panChangList != null
          ? panChangWidget(provider)
          : const SizedBox();
    });
  }

  Widget panChangWidget(HomePageController provider) {
    Iterable<String> panChang = provider.panChangList!.toJson().keys;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: panChang.length,
      itemBuilder: (BuildContext context, int index) {
        if (index > 6) {
          final details;
          // print(provider.panChangList!.toJson()[panChang.elementAt(index)]['details'].length);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(reusableMethods.replaceAndCapitalizeFirstLetter(
                  panChang.elementAt(index)), style: CustomStyles.panChangHeadLinesTxtStyle,),
              widgetCreator(index, provider, panChang),
              const SizedBox(height: 15),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget widgetCreator(int index, HomePageController provider, panChang){
    if(index>6 && index<=10){
      final details = provider.panChangList!.toJson()[panChang.elementAt(index)]['details'];
      final endTime = provider.panChangList!.toJson()[panChang.elementAt(index)]['end_time'];
      return detailsWidget(index, details, endTime);
    }else if(index==11){
      return hinduMahWidget(index, provider);
    }else if(index<=23 || index==25){
      return oneLinerWidget(index, provider, panChang);
    }else if(index<=24 || index>25){
      return const Text("hell");
    }else{
      return const SizedBox();
    }
  }

  Widget detailsWidget(index, details, endTime){
    Iterable<String> detailsKeys = details.keys;
    Iterable<dynamic> detailsValues = details.values;
    Iterable<dynamic> endTimeValues = endTime.values;

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: details.length,
          itemBuilder: (BuildContext context, int index2) {
            print(index2);
            return Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(reusableMethods.replaceAndCapitalizeFirstLetter(detailsKeys.elementAt(index2))+" : ")),
                    Expanded(
                        flex: 2,
                        child: Text("${detailsValues.elementAt(index2)}")),
                  ],
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Expanded(flex: 1, child: Text("End Time")),
            Expanded(
              flex: 2,
              child: Text(endTimeValues.elementAt(0).toString() +
                  " hr " +
                  endTimeValues.elementAt(1).toString() +
                  " min " +
                  endTimeValues.elementAt(2).toString() +
                  " sec "),
            )
          ],
        ),
      ],
    );
  }

  Widget hinduMahWidget(int index, HomePageController provider){
    final hinduMahData = provider.panChangList!.hinduMaah.toJson();
    final hinduMahKeys = hinduMahData.keys;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: hinduMahKeys.length,
        itemBuilder: (BuildContext context, int index2) {
          return Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(reusableMethods.replaceAndCapitalizeFirstLetter(hinduMahKeys.elementAt(index2))+" : ")),
              Expanded(
                  flex: 2,
                  child: Text("${hinduMahData[hinduMahKeys.elementAt(index2)]??"N/A"}")),
            ],
          );
        },
      ),
    );
  }

  Widget oneLinerWidget(int index, HomePageController provider, panChang){
    final panChangData = provider.panChangList!.toJson();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Text(reusableMethods.replaceAndCapitalizeFirstLetter(panChang.elementAt(index))+" : ")),
          Expanded(
              flex: 2,
              child: Text("${panChangData[panChang.elementAt(index)]??"N/A"}")),
        ],
      ),
    );
  }

}