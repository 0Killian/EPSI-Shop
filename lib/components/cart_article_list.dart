import 'package:epsi_shop/providers/cart.dart';
import 'package:flutter/material.dart';

class CartArticleList extends StatelessWidget {
  const CartArticleList({
    super.key,
    required Cart cart,
  }) : _cart = cart;

  final Cart _cart;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _cart.itemCount,
        itemBuilder: (context, index) => ListTile(
          leading: Image.network(
              _cart.items[index].imageUrl,
              width: 50,
              height: 50),
          title: Text(_cart.items[index].name),
          subtitle:
          Text(_cart.items[index].priceInEuros),
          trailing: TextButton(
              onPressed: () =>
                  _cart.removeItem(index),
              child: Text(
                "Supprimer",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .error),
              )),
        ));
  }
}
