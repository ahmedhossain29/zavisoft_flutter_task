## **Flutter Daraz-Style Product Screen**

#### **Introduction**

This screen demonstrates a Daraz-style product listing built using a fully sliver-based layout in Flutter.

**The goal of this implementation was to ensure:**

* A single vertical scrollable
* Sticky tab behavior
* Smooth and predictable scrolling without conflicts

The focus is on scroll architecture and stability rather than only UI design.

### **How Scrolling Works**

**Each tab is built using a CustomScrollView with slivers:**

* SliverAppBar (search bar – always visible)
* SliverToBoxAdapter (promo banner – scrolls away)
* SliverPersistentHeader (tab bar – becomes sticky)
* SliverGrid (product list)

There is only one vertical scroll owner per tab, and no nested vertical scrollables are used.

**Each tab has its own ScrollController, so when switching between tabs:**

* The product list keeps its own scroll position
* The banner collapse state is synchronized
* No jump or scroll reset occurs

This ensures smooth behavior even when different tabs contain different numbers of products.

### **Tab Behavior**

* Tabs can be switched by tapping.
* Each tab loads and manages its own product state.
* Scroll position is preserved independently.
* Pull-to-refresh only refreshes the currently visible tab.

This avoids shared state issues and unexpected UI changes.

### **▶ How to Run**

Clone the repository

Run:

flutter pub get 

flutter run

No additional setup is required.

