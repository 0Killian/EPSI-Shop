import 'dart:convert';

import 'package:epsi_shop/components/cart_article_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../providers/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void _checkout(
      Cart cart, ScaffoldMessengerState messenger, ThemeData theme) async {
    var data = {
      "articles": cart.items
          .map((article) => {
                "name": article.name,
                "price": article.price,
              })
          .toList(),
      "total": cart.total,
      "currency": "EUR"
    };

    try {
      var response = await http.post(
          Uri.parse('https://ptsv3.com/t/EPSISHOPC2/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        messenger
            .showSnackBar(const SnackBar(content: Text("Commande envoyée !")));
      } else {
        throw Exception();
      }

      cart.clear();
    } catch(e) {
      messenger
          .showSnackBar(SnackBar(content: Text("Une erreur est survenue."), backgroundColor: theme.colorScheme.error));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Panier"),
        ),
        body: Consumer<Cart>(builder: (context, cart, child) {
          return Container(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Votre panier total est de"),
                          Text("${cart.total.toStringAsFixed(2)}€"),
                        ]),
                    Flexible(
                        child: Center(
                            child: CartArticleList(cart: cart))),
                    FilledButton(
                      onPressed: cart.itemCount == 0 ? null : () => _checkout(cart,
                          ScaffoldMessenger.of(context), Theme.of(context)),
                      child: const Text("Procéder au paiement"),
                    )
                  ]));
        }));
  }
}
