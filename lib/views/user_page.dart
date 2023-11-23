import 'package:coffe_ecom/main.dart';
import 'package:coffe_ecom/models/addres_model.dart';
import 'package:coffe_ecom/models/payment_model.dart';
import 'package:coffe_ecom/widgets/app_input.dart';
import 'package:coffe_ecom/widgets/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late final void Function() listener;

  List<Widget> _buildAddress(List<AddresModel> addresses) {
    return addresses
        .map((e) => ListTile(
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red[800],
                ),
                onPressed: () {
                  userController.removeAddress(e);
                },
              ),
              title: Text(
                e.name,
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
                          e.street,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Bairro: ${e.neighborhood}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    e.number.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ))
        .toList();
  }

  List<Widget> _buildPayments(List<PaymentModel> payments) {
    return payments
        .map((e) => ListTile(
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red[800],
                ),
                onPressed: () {
                  userController.removePayment(e);
                },
              ),
              title: Text(
                e.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                e.cardValue,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ))
        .toList();
  }

  @override
  void initState() {
    listener = () {
      setState(() {});
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (userController.errorMsg.isNotEmpty) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            userController.errorMsg,
            style: const TextStyle(fontSize: 20),
          ),
        ));
      }
    };

    userController.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    userController.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loggedUser = userController.loggedUser;
    final userName = loggedUser != null ? loggedUser.name : 'Convidado';
    List<Widget> addresses = [];
    List<Widget> payments = [];

    if (loggedUser != null) {
      addresses = _buildAddress(loggedUser.addresses);
      payments = _buildPayments(loggedUser.payments);
    }

    return AppLayout(
      appBarTitle: const Text(
        'Perfil',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Endereços',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      useSafeArea: true,
                      showDragHandle: true,
                      enableDrag: true,
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.brown[300],
                      builder: (context) => const AddAddressModal(),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.1),
              ),
              child: Column(
                children: addresses,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Meios de pagamento',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      useSafeArea: true,
                      showDragHandle: true,
                      enableDrag: true,
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.brown[300],
                      builder: (context) => const AddPaymentModal(),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.1),
              ),
              child: Column(
                children: payments,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Meus Pedidos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.push('/myRequests');
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            loggedUser!.isAdmin
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Gerenciamento',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.push('/manager');
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class AddAddressModal extends StatelessWidget {
  const AddAddressModal({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String name = '';
    String street = '';
    int number = 0;
    String neighborhood = '';

    return Scaffold(
      backgroundColor: Colors.brown[400],
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Adicionar Endereço',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              AppInput(
                label: 'Nome do Endereço',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome do endereço invalido!';
                  }
                  name = value;
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: AppInput(
                      keyboardType: TextInputType.text,
                      label: 'Rua',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nome da rua invalido!';
                        }
                        street = value;
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: AppInput(
                      keyboardType: TextInputType.number,
                      label: 'Número',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'número invalido!';
                        }
                        number = int.parse(value);
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              AppInput(
                keyboardType: TextInputType.text,
                label: 'Bairro',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome do bairro invalido!';
                  }
                  neighborhood = value;
                  return null;
                },
              ),
              const Spacer(),
              Center(
                child: FilledButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final newAddress = AddresModel(
                        name: name,
                        street: street,
                        number: number,
                        neighborhood: neighborhood,
                      );
                      userController.addNewAddress(newAddress);
                      context.pop(newAddress);
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.brown[800],
                    fixedSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Salvar Endereço',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}

class AddPaymentModal extends StatelessWidget {
  const AddPaymentModal({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String cardValue = '';
    String dueDate = '';
    String name = '';
    String securityCode = '';

    return Scaffold(
      backgroundColor: Colors.brown[400],
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Adicionar Cartão de pagamento',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              AppInput(
                label: 'Apelido Cartão',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Apelido invalido!';
                  }
                  name = value;
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: AppInput(
                      keyboardType: TextInputType.number,
                      label: 'Número do cartão',
                      validator: (value) {
                        if (value == null || value.length < 16 || value.length > 16) {
                          return 'Cartão invalido';
                        }
                        cardValue = value;
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: AppInput(
                      keyboardType: TextInputType.number,
                      label: 'CVV',
                      validator: (value) {
                        if (value == null || value.length < 3 || value.length > 3) {
                          return 'CVV Inválido!';
                        }
                        securityCode = value;
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              AppInput(
                keyboardType: TextInputType.datetime,
                label: 'Vencimento (MM/AA)',
                validator: (value) {
                  final reg = RegExp(r'^\d{2}/\d{2}$');
                  if (value == null || value.isEmpty || !reg.hasMatch(value)) {
                    return 'Vencimento inválido';
                  }
                  dueDate = value;
                  return null;
                },
              ),
              const Spacer(),
              Center(
                child: FilledButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final newPayment = PaymentModel(
                        name: name,
                        cardValue: cardValue,
                        dueDate: dueDate,
                        securityCode: securityCode,
                      );
                      userController.addNewPayment(newPayment);
                      context.pop(newPayment);
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.brown[800],
                    fixedSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Salvar Cartão',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
