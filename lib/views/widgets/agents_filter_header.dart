import 'package:flutter/material.dart';
import 'package:india_today/controllers/agents_page_controller.dart';
import 'package:provider/provider.dart';

import '../../custom_styles.dart';

class FilterHeaderWidget extends StatelessWidget {
  const FilterHeaderWidget({
    Key? key,
    required this.sortList,
  }) : super(key: key);

  final List<String> sortList;
  @override
  Widget build(BuildContext context) {
  final provider = Provider.of<AgentsPageController>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Talk To an Astrologer',
          style: CustomStyles.panChangHeadLinesTxtStyle,
        ),
        IconButton(
          icon: Image.asset("assets/images/search.png"),
          onPressed: (){
            provider.toggleSearchBar();
          },
        ),
        IconButton(
          icon: Image.asset("assets/images/filter.png"),
          onPressed: null,
        ),
        PopupMenuButton(
          icon: Image.asset("assets/images/sort.png"),
          itemBuilder: (context) {
            return List.generate(sortList.length, (index) {
              return PopupMenuItem(
                value: sortList[index],
                child: ValueListenableBuilder(
                  valueListenable: provider.selectedSortItem,
                  child: Text(sortList[index]),
                  builder: (BuildContext context, String value, Widget? child){
                    return RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      value: sortList[index],
                      groupValue: value,
                      title: child,
                      onChanged: (val){
                        // selectedSortItem.value = "$val";
                        provider.setRadioItem("$val");
                        // provider.setRadioItem(val);
                        // });
                      },
                    );
                    // title: Text(sortList[index]),
                  },
                ),
              );
            });
          },
        )
        // Consumer<AgentsPageController>(builder: (context, provider, child) {
        //   return ;
        // }),
      ],
    );
  }
}