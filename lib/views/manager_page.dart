import 'package:coffe_ecom/controllers/manager_controller.dart';
import 'package:coffe_ecom/models/manager_model.dart';
import 'package:coffe_ecom/widgets/background_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  final _managerController = ManagerController();

  Map<String, List<ManagerModel>> _groupByDateAndName(List<ManagerModel> sales) {
    Map<String, List<ManagerModel>> result = {};

    sales.sort((a, b) => b.date.compareTo(a.date));

    for (var sale in sales) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(sale.date);

      if (!result.containsKey(formattedDate)) {
        result[formattedDate] = [];
      }

      result[formattedDate]!.add(sale);
    }

    return result;
  }

  @override
  void initState() {
    _managerController.addListener(() => setState(() {}));
    _managerController.getSales();
    super.initState();
  }

  @override
  void dispose() {
    _managerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sales = _groupByDateAndName(_managerController.sales);
    final totalQtde = _managerController.sales.fold(
      0,
      (previousValue, element) => previousValue + element.saledQuantity,
    );
    final totalValue = _managerController.sales.fold(
      0.0,
      (previousValue, element) => previousValue + element.saledValue,
    );

    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Gerenciamento',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total de vendas (qtde):',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '$totalQtde',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total de vendas (R\$):',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    totalValue.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Divider(color: Colors.black),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.1),
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Data',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Qtde',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Total',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      itemCount: sales.length,
                      itemBuilder: (context, i) {
                        final title = sales.keys.elementAt(i);
                        final items = sales[title]!;
                        final quantity = items.fold(
                          0,
                          (previousValue, element) => previousValue + element.saledQuantity,
                        );
                        final total = items.fold(
                          0.0,
                          (previousValue, element) => previousValue + element.saledValue,
                        );
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              total.toStringAsFixed(2),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        );
                      },
                      shrinkWrap: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
