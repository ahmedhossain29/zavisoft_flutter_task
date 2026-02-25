import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          /// ✅ ALWAYS FIXED SEARCH BAR
          const _SearchBar(),

          /// SCROLL AREA
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [

                  /// Flash sale / banner section
                  SliverToBoxAdapter(
                    child: _PromoSection(),
                  ),

                  /// ✅ STICKY TAB BAR
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _TabBarDelegate(
                      const TabBar(
                        tabs: [
                          Tab(text: "All"),
                          Tab(text: "Electronics"),
                          Tab(text: "Jewelery"),
                        ],
                      ),
                    ),
                  ),
                ];
              },

              /// TAB CONTENT
              body: const TabBarView(
                children: [
                  ProductTab(category: "all"),
                  ProductTab(category: "electronics"),
                  ProductTab(category: "jewelery"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 12),
      color: Colors.white,
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search products",
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey.shade200,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
class _PromoSection extends StatelessWidget {
  const _PromoSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          color: Colors.orange.shade100,
          alignment: Alignment.center,
          child: const Text("Flash Sale Banner"),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}



class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) {
    return false;
  }
}

class ProductTab extends StatefulWidget {
  final String category;

  const ProductTab({
    super.key,
    required this.category,
  });

  @override
  State<ProductTab> createState() => _ProductTabState();
}


class _ProductTabState extends State<ProductTab>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // IMPORTANT

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 16,
      itemBuilder: (_, index) {
        return ListTile(
          title: Text("${widget.category} Product $index"),
        );
      },
    );
  }
}