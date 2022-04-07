part of 'ui_library.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  const AppScaffold({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Utils.homeNavigator.currentState!.pushNamed(routeHome);
          },
          icon: Icon(Icons.home),
        ),
        title: IconButton(
          onPressed: () {
            Utils.homeNavigator.currentState!.pushNamed(routeProfile);
          },
          icon: Icon(Icons.account_circle),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                Utils.homeNavigator.currentState!.pushNamed(routeSettings);
              },
              icon: Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: body,
    );
  }
}
