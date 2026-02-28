import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zavisaft_flutter_task/features/Home/presentation/widgets/product_card_widget.dart';
import 'package:zavisaft_flutter_task/features/Home/presentation/widgets/promo_banner_widget.dart';
import 'package:zavisaft_flutter_task/features/Home/presentation/widgets/sticky_tab_bar_delegate.dart';

import '../../../../core/common_widgets/custom_text.dart';
import '../../../../core/utils/utils.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import 'app_bar_widget.dart';

const _tabs = ["All", "Electronics", "Jewelery"];

class TabPage extends StatefulWidget {
  final ScrollController scrollController;
  final TabController tabController;
  final ProductCubit cubit;
  final String category;
  final Future<void> Function() onRefresh;

  const TabPage({
    super.key,
    required this.scrollController,
    required this.tabController,
    required this.cubit,
    required this.category,
    required this.onRefresh,
  });

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      color: Colors.orange,
      child: CustomScrollView(
        controller: widget.scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [

          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 56,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: const FlexibleSpaceBar(
              titlePadding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: SearchBarWidget(),
              centerTitle: false,
            ),
          ),

          const SliverToBoxAdapter(child: PromoBanner()),

          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              height: 48,
              child: TabBar(
                controller: widget.tabController,
                labelColor: Colors.orange,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.orange,
                indicatorWeight: 3,
                labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14),
                tabs: _tabs.map((t) => Tab(text: t)).toList(),
              ),
            ),
          ),

          BlocBuilder<ProductCubit, ProductState>(
            bloc: widget.cubit,
            builder: (_, state) {
              if (state is ProductLoading) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.orange),
                  ),
                );
              }

              if (state is ProductError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            color: Colors.red, size: 48),
                        Utils.verticalSpace(12.0),
                        const CustomText(text: "Something went wrong",fontSize: 16,
                        ),
                        Utils.verticalSpace(12.0),
                        ElevatedButton.icon(
                          onPressed: () =>
                              widget.cubit.fetchProducts(widget.category),
                          icon: const Icon(Icons.refresh),
                          label: const CustomText(text: "Retry"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (state is ProductLoaded && state.products.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox_outlined,
                            size: 64, color: Colors.grey),
                        Utils.verticalSpace(12.0),
                        CustomText(text: "No products found",color: Colors.grey, fontSize: 16
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (state is ProductLoaded) {
                return SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                          (_, index) =>
                          ProductCard(product: state.products[index]),
                      childCount: state.products.length,
                    ),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.68,
                    ),
                  ),
                );
              }

              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}