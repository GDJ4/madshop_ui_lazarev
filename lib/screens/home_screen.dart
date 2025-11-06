import 'package:flutter/material.dart';
import 'package:madshop_ui_lazarev/widgets/product_card.dart';
import 'package:madshop_ui_lazarev/theme/colors.dart';
import 'product_screen.dart';
import 'favorites_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final Set<int> _favorites = {};
  final Set<int> _cart = {};

  final List<Map<String, dynamic>> _products = [
    {
      'id': 1,
      'title': 'ФУТБОЛКА-ОВЕРСАЙЗ «ВЕДОЗЬЯНА»',
      'description': '',
      'price': 3333.00,
      'imagePath': 'lib/assets/images/101.jpg',
    },
    {
      'id': 2,
      'title': 'ФУТБОЛКА-ОВЕРСАЙЗ «ЯДЕРНАЯ ЗИМА»',
      'description': '',
      'price': 5545.00,
      'imagePath': 'lib/assets/images/102.jpg',
    },
    {
      'id': 3,
      'title': 'ФУТБОЛКА-ОВЕРСАЙЗ «СИГИ»',
      'description': '',
      'price': 1453.00,
      'imagePath': 'lib/assets/images/103.jpg',
    },
    {
      'id': 4,
      'title': 'ФУТБОЛКА-ОВЕРСАЙЗ «ЕРЕСЬ»',
      'description': '',
      'price': 5276.00,
      'imagePath': 'lib/assets/images/104.jpg',
    },
    {
      'id': 5,
      'title': 'ФУТБОЛКА-ОВЕРСАЙЗ «ГИПЕРБОРЕЯ»',
      'description': '',
      'price': 2546.00,
      'imagePath': 'lib/assets/images/105.jpg',
    },
    {
      'id': 6,
      'title': 'ФУТБОЛКА-ОВЕРСАЙЗ «НА ВАШИНГТОН»',
      'description': '',
      'price': 2083.00,
      'imagePath': 'lib/assets/images/106.jpg',
    },
    {
      'id': 7,
      'title': 'ФУТБОЛКА-ОВЕРСАЙЗ «CHICKEN»',
      'description': '',
      'price': 13434.00,
      'imagePath': 'lib/assets/images/107.jpg',
    },
    {
      'id': 8,
      'title': 'ФУТБОЛКА-ОВЕРСАЙЗ «AQUA»',
      'description': '',
      'price': 2314.00,
      'imagePath': 'lib/assets/images/108.jpg',
    },
    {
      'id': 9,
      'title': 'РУСЬ',
      'description': 'Бесценно',
      'price': 9999999999999.00,
      'imagePath': 'lib/assets/images/russia_flag.png',
    },

  ];

  void _toggleFavorite(int productId) {
    setState(() {
      if (_favorites.contains(productId)) {
        _favorites.remove(productId);
      } else {
        _favorites.add(productId);
      }
    });
  }

  void _toggleCart(int productId) {
    setState(() {
      if (_cart.contains(productId)) {
        _cart.remove(productId);
      } else {
        _cart.add(productId);
      }
    });
  }

  List<Widget> _getScreens() {
    return [
      ShopContent(
        products: _products,
        favorites: _favorites,
        cart: _cart,
        onFavoriteToggle: _toggleFavorite,
        onCartToggle: _toggleCart,
      ),
      FavoritesScreen(
        products: _products,
        favorites: _favorites,
        cart: _cart,
        onFavoriteToggle: _toggleFavorite,
        onCartToggle: _toggleCart,
      ),
      CartScreen(cartItems: _cart, products: _products),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreens()[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == 0
                  ? 'lib/assets/images/homeS.png'
                  : 'lib/assets/images/home.png',
              width: 30,
              height: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == 1
                  ? 'lib/assets/images/followS.png'
                  : 'lib/assets/images/follow.png',
              width: 35,
              height: 35,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == 2
                  ? 'lib/assets/images/cartS.png'
                  : 'lib/assets/images/cart.png',
              width: 30,
              height: 30,
            ),
            label: '',
          ),
        ],
        selectedFontSize: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}

class ShopContent extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final Set<int> favorites;
  final Set<int> cart;
  final Function(int) onFavoriteToggle;
  final Function(int) onCartToggle;

  const ShopContent({
    super.key,
    required this.products,
    required this.favorites,
    required this.cart,
    required this.onFavoriteToggle,
    required this.onCartToggle,
  });

  @override
  State<ShopContent> createState() => _ShopContentState();
}

class _ShopContentState extends State<ShopContent> {
  String _searchQuery = '';

  List<Map<String, dynamic>> get _filteredProducts {
    if (_searchQuery.trim().isEmpty) {
      return widget.products;
    }
    final query = _searchQuery.toLowerCase();
    return widget.products.where((product) {
      final title = (product['title'] as String).toLowerCase();
      final description = (product['description'] as String).toLowerCase();
      return title.contains(query) || description.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Shop',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Clothing',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(200, 5, 63, 208),
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(200, 214, 217, 236),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: products.isEmpty
                  ? const Center(
                      child: Text(
                        'Nothing matches your search',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductCard(
                          title: product['title'] as String,
                          description: product['description'] as String,
                          price: product['price'] as double,
                          imagePath: product['imagePath'] as String,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductScreen(
                                  product: product,
                                  cart: widget.cart,
                                  onCartToggle: widget.onCartToggle,
                                ),
                              ),
                            );
                          },
                          isFavorite:
                              widget.favorites.contains(product['id']),
                          onFavoriteToggle: () => widget
                              .onFavoriteToggle(product['id'] as int),
                          isInCart: widget.cart.contains(product['id']),
                          onCartToggle: () =>
                              widget.onCartToggle(product['id'] as int),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
