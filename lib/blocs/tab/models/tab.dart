enum AppTab { daily, all }

extension AppTabRoutes on AppTab {
  static const routeNames = {
    AppTab.daily: '/daily',
    AppTab.all: '/all',
  };

  String get routeName => routeNames[this] ?? '/error';
}
