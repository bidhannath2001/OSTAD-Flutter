import 'package:counter/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterProvider>();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(counter.count.toString(), style: TextStyle(fontSize: 80)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      counter.increment();
                    },
                    child: Icon(Icons.add),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      counter.decrement();
                    },
                    child: Icon(Icons.remove),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
