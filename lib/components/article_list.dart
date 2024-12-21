import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/article.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({
    super.key,
    required List<Article> articles,
  }) : _articles = articles;

  final List<Article> _articles;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var article in _articles)
          Card(
            child: ListTile(
              leading: Image.network(article.imageUrl,
                  width: 50, height: 50),
              title: Text(article.name),
              subtitle: Text(
                article.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(article.priceInEuros),
              onTap: () => {context.go("/article", extra: article)},
            ),
          ),
      ],
    );
  }
}
