import 'dart:ui';
import 'package:coffe_ecom/main.dart';
import 'package:coffe_ecom/models/coffe_model.dart';
import 'package:coffe_ecom/widgets/app_layout.dart';
import 'package:flutter/material.dart';

class DescriptionPage extends StatefulWidget {
  final CoffeModel coffe;
  const DescriptionPage({super.key, required this.coffe});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    final coffe = widget.coffe;
    return AppLayout(
      appBarTitle: Text(
        coffe.title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 350,
              color: Colors.black.withOpacity(0.5),
              child: ClipRect(
                clipBehavior: Clip.none,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Image.asset(
                    coffe.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Descrição',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              coffe.discription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton(
                  onPressed: () {
                    setState(() {
                      coffe.size = CoffeSize.small;
                    });
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: coffe.size == CoffeSize.small
                        ? const Color(0xff8C4D21)
                        : const Color.fromARGB(135, 211, 207, 207),
                  ),
                  child: const Text('P'),
                ),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      coffe.size = CoffeSize.medium;
                    });
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: coffe.size == CoffeSize.medium
                        ? const Color(0xff8C4D21)
                        : const Color.fromARGB(135, 211, 207, 207),
                  ),
                  child: const Text('M'),
                ),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      coffe.size = CoffeSize.large;
                    });
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: coffe.size == CoffeSize.large
                        ? const Color(0xff8C4D21)
                        : const Color.fromARGB(135, 211, 207, 207),
                  ),
                  child: const Text('G'),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      final newCoffe = CoffeModel(
                        id: coffe.id,
                        title: coffe.title,
                        price: coffe.price,
                        imagePath: coffe.imagePath,
                        type: coffe.type,
                        discription: coffe.discription,
                        size: coffe.size,
                      );
                      cartController.addCoffeToCart(newCoffe);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xff8C4D21),
                      fixedSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Adicionar no carrinho',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
