import 'package:epsi_shop/models/article.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(article.name),
          actions: [
            IconButton(
              onPressed: () => context.go("/cart"),
              icon: Badge(
                label:
                Text(context.watch<Cart>().items.length.toString()),
                child: const Icon(Icons.shopping_cart),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Column(children: [
              Image.network(
                article.imageUrl,
                height: 300,
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text(article.name,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                maxLines: 2)),
                        Text(
                          article.priceInEuros,
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      ]))
            ])),
            Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "Catégorie: ${article.category}",
                  textAlign: TextAlign.start,
                )),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  article.description,
                  textAlign: TextAlign.start,
                )),
            Center(
                child: OutlinedButton(
                    onPressed: () => context.read<Cart>().addItem(article),
                    child: const Text("Ajouter au panier")))
          ],
        )));
  }
}
