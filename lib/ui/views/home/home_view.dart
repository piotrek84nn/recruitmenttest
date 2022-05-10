import 'package:flutter/material.dart';
import 'package:recrutmenttest/core/enum/view_state.dart';
import 'package:recrutmenttest/core/vm/home/home_view_model.dart';
import 'package:recrutmenttest/ui/helpers/ui_helpers.dart';
import 'package:recrutmenttest/ui/views/base_widget.dart';
import 'package:recrutmenttest/ui/views/home/content_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final TextEditingController patternCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      viewModel: HomeViewModel(),
      onViewModelReady: (model) async {
        model.tabController = TabController(length: 3, vsync: this);
        await model.initModel(patternCtrl);
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          actions: [
            getSearchTxtField(model, patternCtrl),
            IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    patternCtrl.clear();
                    model.filterItemsOnList('');
                    FocusScope.of(context).unfocus();
                  });
                }),
          ],
          bottom: TabBar(
            controller: model.tabController,
            indicatorWeight: 10,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.blue[200],
            indicatorColor: Colors.blue,
            labelStyle: const TextStyle(fontSize: 16),
            tabs: const [
              Tab(text: 'all'),
              Tab(text: 'spot'),
              Tab(text: 'feuature'),
            ],
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            return model.backAction();
          },
          child: model.state == ViewState.idle ? DefaultTabController(
            length: 3,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ContentList(
                    data: model.resultList, sortFunction: model.sortResultList, selectedColumn: model.columnNumber),
                ContentList(
                    data: model.resultList, sortFunction: model.sortResultList, selectedColumn: model.columnNumber),
                ContentList(
                    data: model.resultList, sortFunction: model.sortResultList, selectedColumn: model.columnNumber),
              ],
            ),
          ) : UIHelper.getCircularProgressIndicator(),
        ),
      ),
    );
  }

  Expanded getSearchTxtField(
      HomeViewModel model, TextEditingController? txtCtrl) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: txtCtrl,
        onChanged: model.filterItemsOnList,
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.blue[200]),
        ),
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ));
  }

  @override
  void dispose() {
    patternCtrl.dispose();
    super.dispose();
  }
}
