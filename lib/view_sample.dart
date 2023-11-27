/*

@RoutePage()
class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(viewModelBuilder: (_) => locator<HomeScreenViewModel>(), builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, HomeScreenViewModel homeScreenViewModel) {
    {
      return Container();
    }
  }
}

get
  int get unreadMessagesCount => _unreadMessagesCount;
set
  set unreadMessagesCount(int value) {
    _unreadMessagesCount = value;
    notifyListeners();
  }

*/