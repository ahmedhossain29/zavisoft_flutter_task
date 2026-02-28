import 'package:flutter/material.dart';
import '../../../../core/di/injector.dart';
import '../cubit/product_cubit.dart';
import '../widgets/tab_page.dart';


const _tabs = ["All", "Electronics", "Jewelery"];
const _categories = ["all", "electronics", "jewelery"];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final List<ProductCubit> _cubits;
  late final List<ScrollController> _scrollControllers;

  static const double _bannerHeight = 200.0;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);

    _cubits = List.generate(_tabs.length, (i) {
      final cubit = sl<ProductCubit>();
      cubit.fetchProducts(_categories[i]);
      return cubit;
    });

    _scrollControllers = List.generate(
      _tabs.length,
          (_) => ScrollController(),
    );

    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;

    final newIndex = _tabController.index;
    if (newIndex == _currentIndex) return;

    _syncHeaderOffset(from: _currentIndex, to: newIndex);

    setState(() => _currentIndex = newIndex);
  }


  void _syncHeaderOffset({required int from, required int to}) {
    final fromOffset = _scrollControllers[from].hasClients
        ? _scrollControllers[from].offset
        : 0.0;

    final toController = _scrollControllers[to];
    if (!toController.hasClients) return;

    final toOffset = toController.offset;
    final double headerState = fromOffset.clamp(0.0, _bannerHeight);

    final double productScroll =
    (toOffset - _bannerHeight).clamp(0.0, double.infinity);

    final double targetOffset = headerState + productScroll;

    if ((toOffset - targetOffset).abs() > 1.0) {
      toController.jumpTo(targetOffset);
    }
  }

  Future<void> _onRefresh() async {
    await _cubits[_currentIndex].refresh(_categories[_currentIndex]);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    for (final c in _cubits) c.close();
    for (final s in _scrollControllers) s.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: List.generate(_tabs.length, (i) {
          return Offstage(
            offstage: _currentIndex != i,
            child: TabPage(
              scrollController: _scrollControllers[i],
              tabController: _tabController,
              cubit: _cubits[i],
              category: _categories[i],
              onRefresh: _onRefresh,
            ),
          );
        }),
      ),
    );
  }
}






