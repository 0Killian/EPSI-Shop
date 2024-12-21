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
    return ListView.builder(
      itemCount: _articles.length,
      itemBuilder: (context, index) =>
          Card(
            child: ListTile(
              leading: Image.network(_articles[index].imageUrl,
                  width: 50, height: 50),
              title: Text(_articles[index].name),
              subtitle: Text(
                _articles[index].description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(_articles[index].priceInEuros),
              onTap: () => {context.go("/article", extra: _articles[index])},
            ),
          ),
    );
  }
}
