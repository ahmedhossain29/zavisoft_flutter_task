import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injector.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../../domain/entities/product.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(length: 3, child: _HomeView());
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return const SizedBox(); // hide
          }

          return Container(
            padding: const EdgeInsets.all(12),
            color: Colors.orange.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Login to see your profile"),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          );
        },
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, _) {
          return [
            /// 🔹 FIXED SEARCH BAR
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0,
              titleSpacing: 0,
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: _SearchBar(),
              ),
            ),

            /// 🔹 PROMO SECTION
            const SliverToBoxAdapter(child: _PromoSection()),

            /// 🔹 STICKY TAB BAR
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarDelegate(
                const TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Colors.orange,
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

        /// 🔹 TAB CONTENT
        body: TabBarView(
          children: [
            BlocProvider(
              create: (_) => sl<ProductCubit>()..fetchProducts("all"),
              child: const ProductTab(category: "all"),
            ),
            BlocProvider(
              create: (_) => sl<ProductCubit>()..fetchProducts("electronics"),
              child: const ProductTab(category: "electronics"),
            ),
            BlocProvider(
              create: (_) => sl<ProductCubit>()..fetchProducts("jewelery"),
              child: const ProductTab(category: "jewelery"),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 8),
          Text("Search products", style: TextStyle(color: Colors.grey)),
        ],
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
          height: 200,
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
    return Container(color: Colors.white, child: tabBar);
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(_) => false;
}

class ProductTab extends StatefulWidget {
  final String category;

  const ProductTab({super.key, required this.category});

  @override
  State<ProductTab> createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("Init: ${widget.category}");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProductLoaded) {
          return GridView.builder(
            key: PageStorageKey(widget.category),
        //    physics: const NeverScrollableScrollPhysics(),
            physics: const ClampingScrollPhysics(),
            // important
            padding: const EdgeInsets.all(12),
            itemCount: state.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              childAspectRatio: 0.68,
            ),
            itemBuilder: (context, index) {
              final product = state.products[index];
              return _ProductCard(product: product);
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.network(product.image, fit: BoxFit.contain),
            ),
          ),

          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
