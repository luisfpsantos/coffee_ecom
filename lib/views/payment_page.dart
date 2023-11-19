import 'dart:ui';
import 'package:coffe_ecom/main.dart';
import 'package:coffe_ecom/models/addres_model.dart';
import 'package:coffe_ecom/models/payment_model.dart';
import 'package:coffe_ecom/views/user_page.dart';
import 'package:coffe_ecom/widgets/app_layout.dart';
import 'package:coffe_ecom/widgets/background_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  AddresModel? address = userController.loggedUser!.addresses.isEmpty
      ? null
      : userController.loggedUser!.addresses.first;

  PaymentModel? payment = userController.loggedUser!.payments.isEmpty
      ? null
      : userController.loggedUser!.payments.first;

  bool success = false;

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: success
              ? BackButton(
                  onPressed: () {
                    cartController.cartCoffes = [];
                    bottomNavigationIndex = 0;
                    context.pop();
                    context.pushReplacement('/');
                  },
                )
              : null,
          iconTheme: const IconThemeData(color: Colors.white),
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Pagamento',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        body: success
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Center(
                    child: Icon(
                      Icons.verified,
                      size: 300,
                      color: Color(0xff8C4D21),
                    ),
                  ),
                  const Text(
                    'Sua compra foi efetuada!',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: () {
                      cartController.cartCoffes = [];
                      bottomNavigationIndex = 0;
                      context.pop();
                      context.pushReplacement('/');
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xff8C4D21),
                      fixedSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Continuar comprando',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              )
            : Container(
                color: Colors.black.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 500, sigmaY: 500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Resumo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: cartController.cartCoffes.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 15),
                          itemBuilder: (context, i) {
                            final coffe = cartController.cartCoffes[i];
                            return Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    coffe.quantity.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    coffe.coffe.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    coffe.coffe.size.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Divider(),
                      const SizedBox(height: 15),
                      const Text(
                        'Endereço de entrega',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: address == null
                            ? ListTile(
                                title: const Text(
                                  'Adicione um endereço de entrega',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () async {
                                    final result = await showModalBottomSheet(
                                      useSafeArea: true,
                                      showDragHandle: true,
                                      enableDrag: true,
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.brown[300],
                                      builder: (context) => const AddAddressModal(),
                                    );

                                    if (result is AddresModel) {
                                      setState(() {
                                        address = result;
                                      });
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : ListTile(
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    final result = await showModalBottomSheet(
                                      useSafeArea: true,
                                      showDragHandle: true,
                                      enableDrag: true,
                                      context: context,
                                      backgroundColor: Colors.brown[400],
                                      builder: (context) => const ChangeAddressModal(),
                                    );

                                    if (result is AddresModel) {
                                      setState(() {
                                        address = result;
                                      });
                                    }
                                  },
                                ),
                                title: Text(
                                  address!.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            address!.street,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Bairro: ${address!.neighborhood}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      address!.number.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      const SizedBox(height: 15),
                      const Divider(),
                      const SizedBox(height: 15),
                      const Text(
                        'Metodo de pagamento',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: payment == null
                            ? ListTile(
                                title: const Text(
                                  'Adicione um metodo de pagamento',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () async {
                                    final result = await showModalBottomSheet(
                                      useSafeArea: true,
                                      showDragHandle: true,
                                      enableDrag: true,
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.brown[300],
                                      builder: (context) => const AddPaymentModal(),
                                    );

                                    if (result is PaymentModel) {
                                      setState(() {
                                        payment = result;
                                      });
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : ListTile(
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    final result = await showModalBottomSheet(
                                      useSafeArea: true,
                                      showDragHandle: true,
                                      enableDrag: true,
                                      context: context,
                                      backgroundColor: Colors.brown[400],
                                      builder: (context) => const ChangePaymentModal(),
                                    );

                                    if (result is PaymentModel) {
                                      setState(() {
                                        payment = result;
                                      });
                                    }
                                  },
                                ),
                                title: Text(
                                  payment!.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  payment!.cardValue,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 50),
                      payment != null && address != null
                          ? Center(
                              child: FilledButton(
                                onPressed: () {
                                  setState(() {
                                    success = true;
                                  });
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xff8C4D21),
                                  fixedSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Comprar R\$: ${cartController.getCartTotalValue().toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class ChangeAddressModal extends StatelessWidget {
  const ChangeAddressModal({super.key});

  @override
  Widget build(BuildContext context) {
    final addresses = userController.loggedUser!.addresses;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return ListTile(
                  onTap: () => context.pop(address),
                  title: Text(
                    address.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              address.street,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Bairro: ${address.neighborhood}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        address.number.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
          Center(
            child: FilledButton(
              onPressed: () async {
                final result = await showModalBottomSheet(
                  useSafeArea: true,
                  showDragHandle: true,
                  enableDrag: true,
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.brown[300],
                  builder: (context) => const AddAddressModal(),
                );
                // ignore: use_build_context_synchronously
                context.pop(result);
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.brown[800],
                fixedSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Adicionar um novo endereço',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}

class ChangePaymentModal extends StatelessWidget {
  const ChangePaymentModal({super.key});

  @override
  Widget build(BuildContext context) {
    final payments = userController.loggedUser!.payments;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: payments.length,
              itemBuilder: (context, index) {
                final payment = payments[index];
                return ListTile(
                  onTap: () => context.pop(payment),
                  title: Text(
                    payment.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    payment.cardValue,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
          Center(
            child: FilledButton(
              onPressed: () async {
                final result = await showModalBottomSheet(
                  useSafeArea: true,
                  showDragHandle: true,
                  enableDrag: true,
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.brown[300],
                  builder: (context) => const AddPaymentModal(),
                );
                // ignore: use_build_context_synchronously
                context.pop(result);
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.brown[800],
                fixedSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Adicionar um novo pagamento',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
