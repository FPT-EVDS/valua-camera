import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class ViolationScreen extends StatelessWidget {
  const ViolationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: SizedBox(
              width: 250,
              child: DropdownSearch<String>(
                mode: Mode.DIALOG,
                showSelectedItems: true,
                items: const ["Brazil", "Tunisia", 'Canada'],
                dropdownSearchDecoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                ),
                onChanged: print,
                selectedItem: "Brazil",
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            "SU21_PRJ321_10W",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "10",
                                style: TextStyle(color: Colors.green.shade700),
                              ),
                              Text(
                                "Violations",
                                style: TextStyle(color: Colors.grey.shade600),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: 2),
        )
      ],
    );
  }
}
