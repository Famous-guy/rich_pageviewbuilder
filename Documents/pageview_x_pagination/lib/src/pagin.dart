import 'package:flutter/material.dart';

class Pagin extends StatefulWidget {
  const Pagin({super.key});

  @override
  State<Pagin> createState() => _PaginState();
}

class _PaginState extends State<Pagin> {
  final controller = PageController();
  bool end = false;
  List<String> items = List.generate(
    10,
    (index) {
      return 'Item ${index + 1}';
    },
  );
  List<Color> color = [
    Colors.red,
    Colors.grey,
    Colors.pink,
    Colors.purpleAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.teal,
    Colors.redAccent,
    Colors.deepOrange,
    Colors.lightBlueAccent,
  ];
  bool isLoading = false;
  bool canLoadMore = true; // Track if more items can be loaded
  Set<int> loadedPages = {}; // Set to track loaded pages

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent) {
        if (!isLoading && canLoadMore) {
          fetch();
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void fetch() {
    setState(() {
      isLoading = true;
    });

    // Simulate a fetch operation
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        if (items.length >= 20) {
          // Example condition to stop loading more after reaching 20 items
          canLoadMore = false;
          end = true;
        }
        items.addAll([
          'Items A',
          'Items B',
          'Items C',
          'Items D',
          'Items E',
          'Items F',
          'Items G',
          'Items H',
          'Items I',
          'Items J',
          'Items K',
          'Items L'
        ]);
        isLoading = false;
        loadedPages.add(items.length ~/ 10); // Mark current page as loaded
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: items.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final colors = color[index % color.length];
                  return Container(
                    decoration: BoxDecoration(
                      color: colors,
                    ),
                    child: Center(
                      child: Text('hello world $item'),
                    ),
                  );
                },
              ),
            ),
            if (controller.hasClients &&
                controller.page != null &&
                !loadedPages.contains(controller.page!.round()) &&
                isLoading) // Show loader conditionally
              const LinearProgressIndicator(
                color: Colors.red,
                backgroundColor: Colors.blueGrey,
              ),
            // if (end && !isLoading) const Text('end'),
            // if(!isLoading && items.length == index)
          ],
        ),
      ),
    );
  }
}
