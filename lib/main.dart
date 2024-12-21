import 'dart:convert';

import 'package:epsi_shop/page/article_detail.dart';
import 'package:epsi_shop/page/cart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'models/article.dart';
import 'components/article_list.dart';
import 'providers/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Cart(),
      child: MaterialApp.router(
          title: 'EPSI Shop',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: GoRouter(routes: [
            GoRoute(
                path: "/",
                builder: (context, state) =>
                    const MyHomePage(),
                routes: [
                  GoRoute(
                      path: "article",
                      builder: (context, state) =>
                          ArticleDetailPage(article: state.extra as Article)),
                  GoRoute(
                      path: "cart",
                      builder: (context, state) => const CartPage())
                ]),
          ]),
          debugShowCheckedModeBanner: false),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  Future<List<Article>> _fetchArticles() async {
    return await http
        .get(Uri.parse('https://fakestoreapi.com/products'))
        .then((articlesJsonResponse) =>
            jsonDecode(articlesJsonResponse.body) as List)
        .then((articlesJson) => articlesJson
            .map((articleJson) => Article.fromJson(articleJson))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("EPSI Shop"),
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
      body: Center(
          child: FutureBuilder(
            future: _fetchArticles(),
              builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ArticleList(articles: snapshot.data!);
              } else if (snapshot.hasError) {
                return const Text("Une erreur est survenue.");
              } else {
                return const CircularProgressIndicator();
              }
            })
      ),
    );
  }
}
