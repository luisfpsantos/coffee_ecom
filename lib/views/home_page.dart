import 'package:coffe_ecom/controllers/home_controller.dart';
import 'package:coffe_ecom/widgets/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _coffeController = HomeController();
  final searchController = TextEditingController();
  int _pageIndex = 1;

  Widget _buildOption({
    required String title,
    required String image,
    required String price,
    required void Function() ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              image,
              scale: 6,
            ),
            Text(
              price,
              style: const TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String title, bool selected, void Function() ontap) {
    return FilledButton(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        backgroundColor: selected ? const Color(0xff854C1F) : const Color(0xff1A2438),
      ),
      onPressed: ontap,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  void _searchCoffes(String coffeType, int currentPageIndex) {
    if (coffeType == 'hot_coffe' && currentPageIndex != 1) {
      _coffeController.getCoffes(coffeType);
      _pageIndex = 1;
      searchController.text = '';
      _coffeController.filteredCoffes.clear();
    }

    if (coffeType == 'cold_coffe' && currentPageIndex != 2) {
      _coffeController.getCoffes(coffeType);
      _pageIndex = 2;
      searchController.text = '';
      _coffeController.filteredCoffes.clear();
    }

    if (coffeType == 'special_drinks' && currentPageIndex != 3) {
      _coffeController.getCoffes(coffeType);
      _pageIndex = 3;
      searchController.text = '';
      _coffeController.filteredCoffes.clear();
    }
  }

  @override
  void initState() {
    _coffeController.getCoffes('hot_coffe');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      showUserIcon: true,
      appBarTitle: RichText(
        text: const TextSpan(
          style: TextStyle(fontSize: 25),
          children: [
            TextSpan(
              text: 'Coffee',
              style: TextStyle(
                fontSize: 30,
                color: Color(0xff8C4D21),
                fontWeight: FontWeight.w600,
                shadows: [Shadow(blurRadius: 0.1)],
              ),
            ),
            TextSpan(
              text: 'Ecom',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 0.1)],
              ),
            ),
          ],
        ),
      ),
      body: ListenableBuilder(
        listenable: _coffeController,
        builder: (context, child) {
          if (_coffeController.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.brown[400],
              ),
            );
          }
          if (_coffeController.errorMsg.isNotEmpty) {
            return Center(
              child: Text(_coffeController.errorMsg),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  onChanged: (value) {
                    _coffeController.searchCoffes(value.toLowerCase());
                  },
                  style: const TextStyle(color: Color.fromARGB(255, 116, 64, 27)),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Pesquise sua bebida',
                    isDense: true,
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      highlightColor: Colors.transparent,
                      icon: const Icon(Icons.search, size: 30),
                      onPressed: () {
                        final value = searchController.text.toLowerCase();
                        _coffeController.searchCoffes(value);
                      },
                    ),
                    suffixIconConstraints: const BoxConstraints(minWidth: 70),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          'Categorias',
                          style: TextStyle(
                            fontSize: 25,
                            color: Color(0xff8C4D21),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _buildButton(
                              'Bebidas quentes',
                              _pageIndex == 1,
                              () => _searchCoffes('hot_coffe', _pageIndex),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: _buildButton(
                              'Bebidas geladas',
                              _pageIndex == 2,
                              () => _searchCoffes('cold_coffe', _pageIndex),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: _buildButton(
                              'Bebidas especiais',
                              _pageIndex == 3,
                              () => _searchCoffes('special_drinks', _pageIndex),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Colors.brown,
                        indent: 25,
                        endIndent: 25,
                      ),
                      const SizedBox(height: 10),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.6,
                        ),
                        itemBuilder: (context, i) {
                          final coffe = _coffeController.filteredCoffes.isNotEmpty
                              ? _coffeController.filteredCoffes[i]
                              : _coffeController.coffes[i];

                          return _buildOption(
                            title: coffe.title,
                            image: coffe.imagePath,
                            price: 'R\$: ${coffe.price.toStringAsFixed(2)}',
                            ontap: () {
                              context.push('/coffeDetails', extra: coffe);
                            },
                          );
                        },
                        itemCount: _coffeController.filteredCoffes.isNotEmpty
                            ? _coffeController.filteredCoffes.length
                            : _coffeController.coffes.length,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
