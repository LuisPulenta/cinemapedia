import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'home_screen';
  final int pageIndex;

  const HomeScreen({Key? key, required this.pageIndex}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//* Este Mixin es necesario para mantener el estado en el PageView

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
//-----------------------------------------------------------
//--------------------- Variable ----------------------------
//-----------------------------------------------------------
  late PageController pageController;

  final viewRoutes = const <Widget>[
    HomeView(),
    PopularView(), // <--- categorias View
    FavoritesView(),
  ];

//-----------------------------------------------------------
//--------------------- initState ---------------------------
//-----------------------------------------------------------
  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

//-----------------------------------------------------------
//--------------------- Pantalla ----------------------------
//-----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (pageController.hasClients) {
      pageController.animateToPage(
        widget.pageIndex,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250),
      );
    }

    // return Scaffold(
    //   body: PageView(
    //     //* Esto evitará que rebote
    //     physics: const NeverScrollableScrollPhysics(),
    //     controller: pageController,
    //     // index: pageIndex,
    //     children: viewRoutes,
    //   ),
    //   bottomNavigationBar: CustomBottomNavigation(
    //     currentIndex: widget.pageIndex,
    //   ),
    // );
    return Scaffold(
      body: IndexedStack(
        index: widget.pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: widget.pageIndex,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
