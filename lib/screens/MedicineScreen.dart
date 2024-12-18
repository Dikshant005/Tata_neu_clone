import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/screens/MedicineItemDetails.dart';

final medicineItemsProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {
      "name": "Paracetamol",
      "category": "Pain Reliever",
      "price": "\$5.00",
      "image": "assets/images/paracetamol.png",
    },
    {
      "name": "Ibuprofen",
      "category": "Anti-inflammatory",
      "price": "\$8.00",
      "image": "assets/images/ibuprofen.png",
    },
    {
      "name": "Amoxicillin",
      "category": "Antibiotic",
      "price": "\$12.00",
      "image": "assets/images/amoxicillin.png",
    },
    {
      "name": "Lisinopril",
      "category": "Blood Pressure",
      "price": "\$10.00",
      "image": "assets/images/lisinopril.png",
    },
    {
      "name": "Metformin",
      "category": "Diabetes",
      "price": "\$15.00",
      "image": "assets/images/metformin.png",
    },
    {
      "name": "Aspirin",
      "category": "Pain Reliever",
      "price": "\$4.00",
      "image": "assets/images/aspirin.png",
    },
    {
      "name": "Cetirizine",
      "category": "Allergy",
      "price": "\$6.00",
      "image": "assets/images/cetirizine.png",
    },
  ];
});

final searchQueryProvider = StateProvider<String>((ref) => "");

class MedicineScreen extends ConsumerWidget {

  const MedicineScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicineItems = ref.watch(medicineItemsProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    final filteredItems = medicineItems
        .where((item) =>
            item["name"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            const Text('Medicine Store', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search items...',
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (query) {
                ref.read(searchQueryProvider.notifier).state = query;
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.7, // Aspect ratio for the grid items
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    color: const Color.fromARGB(255, 223, 237, 237),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicineItemDetail(
                              name: item["name"]!,
                              category: item["category"]!,
                              price: item["price"]!,
                              image: item["image"]!,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            item["image"]!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Text(item["name"]!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                            "${item["category"]} - ${item["price"]}",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
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
