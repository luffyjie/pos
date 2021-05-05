import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pos/models/channe_model.dart';
import 'package:pos/router/app_router.dart';
import 'package:pos/services/global.dart';
import 'package:pos/store/cash_in_store.dart';
import 'package:pos/utils/utils.dart';
import 'package:pos/widgets/app_bar.dart';

class CashIn extends StatefulWidget {
  @override
  _CashInState createState() => _CashInState();
}

class _CashInState extends State<CashIn> {
  final _store = CashInStore();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    var result = await getChannelConfig(1);
    if (result['data'] != null) {
      var data = result['data']
          .map<ChannelModel>((item) => ChannelModel.fromJson(item))
          .toList();
      _store.changeData(data);
    }
  }

  _channelTap(String? icon, String? name, int? type) {
    var map = {'businessType': 1, 'type': type, 'name': name, 'icon': icon};
    var json = jsonEncode(map);
    var query = Uri.encodeComponent(json);
    AppRouter.push(context, '${Routes.cashInForm}?data=$query');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Cash Money'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Observer(builder: (_) {
            List<Widget> children = [];
            if (_store.data.length > 0) {
              for (var item in _store.data) {
                children.addAll(_channelGird(item));
              }
            }
            return Column(
              children: children,
            );
          }),
        ),
      ),
    );
  }

  List<Widget> _channelGird(ChannelModel model) {
    var header = Container(
      padding: EdgeInsets.only(top: 20, left: 20),
      alignment: Alignment.centerLeft,
      child: Text(model.largeChannel ?? '',
          style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 16)),
    );
    List<Widget> list = [];
    List<SubChannelModel> channelList = model.channelList ?? [];
    for (var item in channelList) {
      var channel =
          _channel(item.channelLogo, item.channelName, item.channelId);
      list.add(channel);
    }
    var child = Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.9,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: list,
      ),
    );
    return [header, child];
  }

  Widget _channel(String? icon, String? name, int? type) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 2, bottom: 5, right: 2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primaryVariant.withAlpha(50),
              offset: Offset(0, 2),
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(8.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            splashColor: Theme.of(context).primaryColor.withAlpha(100),
            onTap: () {
              if (type == 1) {
                _channelTap(icon, name, type);
              }
            },
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Image.network(
                    networkIcon(icon),
                    fit: BoxFit.contain,
                  ),
                  Expanded(
                    child: Text(
                      name ?? '',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
