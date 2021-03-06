import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pos/router/app_router.dart';
import 'package:pos/store/user_store.dart';
import 'package:pos/utils/utils.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  showExit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you want to exit？'),
        actions: <Widget>[
          ElevatedButton(
              child: Text('Exit'),
              onPressed: () async {
                UserStore.remove();
                AppRouter.exit();
              }),
          ElevatedButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          )
        ],
      ),
    );
  }

  _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();
    if (statuses[Permission.camera] == PermissionStatus.granted) {
      // AppScan.getInstance().getMethod(Methods.qrcode, {});
    } else {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          showExit();
          return Future.value(false);
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 20),
              height: 85,
              color: colorScheme.primaryVariant,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      assetsIcon('home_logo'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.storefront,
                            color: colorScheme.onPrimary,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '0001-Singapor',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: colorScheme.onPrimary, fontSize: 15),
                          ),
                          Spacer(),
                          InkWell(
                            child: Icon(
                              Icons.menu,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
                color: colorScheme.secondaryVariant,
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(flex: 1, child: _scan()),
                    SizedBox(height: 5.5),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          _card('cashin', 'Cash Money ', onTap: () {
                            AppRouter.push(context, Routes.cashIn);
                          }),
                          SizedBox(width: 5.5),
                          _card('buyload', 'Mobile', onTap: () {
                            // AppRouter.push(context, Routes.buyload);
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.5),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          _card('sendmoney', 'Remit', onTap: () {
                            // AppRouter.push(context, Routes.sendMoney);
                          }),
                          SizedBox(width: 5),
                          _card('paybills', 'Bills'),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.5),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          _card('cashpickup', 'Loan'),
                          SizedBox(width: 5.5),
                          _card('kyc', 'admission'),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.5),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          _card('transactions', 'Transactions', onTap: () {
                            // AppRouter.push(context, Routes.transactionHistory);
                          }),
                          SizedBox(width: 5),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(String icon, String name, {void Function()? onTap}) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Material(
        borderRadius: BorderRadius.circular(2.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(2.0),
          splashColor: colorScheme.primary.withAlpha(100),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    width: 34,
                    child: Image.asset(
                      assetsIcon(icon),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  name,
                  style: textTheme.bodyText2?.copyWith(
                    color: colorScheme.primaryVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _scan() {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    return Material(
      borderRadius: BorderRadius.circular(2.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(2.0),
        splashColor: colorScheme.primary.withAlpha(100),
        onTap: _requestPermissions,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  width: 45,
                  child: Image.asset(
                    assetsIcon('scan'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Scan',
                style: textTheme.bodyText2?.copyWith(
                  color: colorScheme.primaryVariant,
                  fontSize: 21,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
