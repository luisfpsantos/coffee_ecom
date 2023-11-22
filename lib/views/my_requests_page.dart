import 'package:coffe_ecom/controllers/my_requests_controller.dart';
import 'package:coffe_ecom/main.dart';
import 'package:coffe_ecom/models/my_request_model.dart';
import 'package:coffe_ecom/widgets/background_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyRequestsPage extends StatefulWidget {
  const MyRequestsPage({super.key});

  @override
  State<MyRequestsPage> createState() => _MyRequestsPageState();
}

class _MyRequestsPageState extends State<MyRequestsPage> {
  final _myRequestsController = MyRequestsController();

  @override
  void initState() {
    _myRequestsController.addListener(() => setState(() {}));
    _myRequestsController.getMyRequests(userController.loggedUser!.id);
    super.initState();
  }

  @override
  void dispose() {
    _myRequestsController.dispose();
    super.dispose();
  }

  Map<String, List<MyRequestModel>> _groupByDateAndName(List<MyRequestModel> myRequests) {
    Map<String, List<MyRequestModel>> result = {};

    myRequests.sort((a, b) => b.date.compareTo(a.date));

    for (var item in myRequests) {
      final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(item.date);

      if (!result.containsKey(formattedDate)) {
        result[formattedDate] = [];
      }

      result[formattedDate]!.add(item);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    Widget body() {
      if (_myRequestsController.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (_myRequestsController.errorMsg.isNotEmpty) {
        return Center(
          child: Text(
            _myRequestsController.errorMsg,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
        );
      }
      final requests = _groupByDateAndName(_myRequestsController.myRequests);
      return ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: requests.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, i) {
          final title = requests.keys.elementAt(i);
          final items = requests[title]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              ...items.map(
                (item) => Container(
                  height: 120,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 100,
                        child: Image.asset(item.coffe.imagePath),
                      ),
                      Text(
                        item.quantity.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.coffe.title,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            item.coffe.size.name,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'R\$: ${item.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      );
    }

    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Meus pedidos',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        body: body(),
      ),
    );
  }
}
