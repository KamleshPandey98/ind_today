import 'package:flutter/material.dart';
import 'package:india_today/controllers/agents_page_controller.dart';
import 'package:india_today/views/widgets/agents_filter_header.dart';
import 'package:india_today/views/widgets/header.dart';
import 'package:provider/provider.dart';

import '../custom_styles.dart';

class TalkToAstrologer extends StatefulWidget {
  const TalkToAstrologer({Key? key}) : super(key: key);

  @override
  _TalkToAstrologerState createState() => _TalkToAstrologerState();
}

class _TalkToAstrologerState extends State<TalkToAstrologer> {

  final AgentsPageController _agentsController = AgentsPageController();
  var selectedSortItem = "";
  // static final ValueNotifier<String> selectedSortItem = ValueNotifier<String>("N/A");


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    awaitInitMethod();
  }

  awaitInitMethod()async{
    await _agentsController.fetchAllAgents();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const Header(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FilterHeaderWidget(sortList: _agentsController.sortList),
              Consumer<AgentsPageController>(builder: (context, provider, child) {
                return provider.showSearchBar ? Card(
                  child: ListTile(
                    // tileColor: Color(0xbcfafafa),
                    leading: const Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 28,
                    ),
                    title: TextField(
                      controller: AgentsPageController.searchTxtController,
                      onChanged: (String val){
                        provider.setFilterAgentsList(val);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search Astrologer',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                        size: 28,
                      ),
                      onPressed: () {
                        setState(() {
                          AgentsPageController.searchTxtController.clear();
                          provider.setFilterAgentsList("");
                        });
                      },
                    ),
                  ),
                ): const SizedBox();
              }),
              agentsListWidget(),
            ],
          ),
        ),
      ),
    );
  }


  // Show Agents List
  Expanded agentsListWidget() {
    return Expanded(
      child: Consumer<AgentsPageController>(builder: (context, provider, child) {
        return provider.allAgentsList.isNotEmpty ? ListView.builder(
          itemCount: provider.filterAgentsList.length,
          itemBuilder: (BuildContext context, int index) {
            final agent = provider.filterAgentsList;
            final skills = [];
            final languages = [];
            if(agent[index].skills!=null || agent[index].skills.isNotEmpty){
              agent[index].skills.forEach((element) {
                skills.add(element.name);
              });
            }
            if(agent[index].languages!=null || agent[index].languages.isNotEmpty){
              agent[index].languages.forEach((element) {
                languages.add(element.name);
              });
            }

            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    minVerticalPadding: 0.0,
                    leading: imager(agent, index),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(agent[index].firstName+" " +agent[index].lastName, style: CustomStyles.panChangHeadLinesTxtStyle),
                        const SizedBox(height: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.account_circle_outlined),
                            const SizedBox(width: 5),
                            Flexible(child: Text(skills.join(", "))),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.language),
                            const SizedBox(width: 5),
                            Flexible(child: Text(languages.join(", "))),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.monetization_on_outlined),
                            const SizedBox(width: 5),
                            Flexible(child: Text("\u{20B9}${agent[index].additionalPerMinuteCharges}/ Min", style: CustomStyles.panChangHeadLinesTxtStyle,)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.call_rounded,
                              // color: Colors.green,
                              size: 30.0,
                            ),
                            label: const Text('Take on Call'),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: CustomStyles.callAgentBtnColor,
                              textStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("${agent[index].experience} Years"),
                      ],
                    ),
                  ),
                ),
                const Divider(),
              ],
            );
          },
        ) : const SizedBox();
      }),
    );
  }

  Widget imager(agent, int index){
    return Image.network(
      agent[index].images.medium.imageUrl,
      errorBuilder: (context, url, error) => const Icon(Icons.error),
    );
  }
}


