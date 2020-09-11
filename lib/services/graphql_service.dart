import "package:flutter/material.dart";
import 'package:graphql/client.dart';

class GraphQLConfiguration {
  static HttpLink httpLink = HttpLink(
    uri:
    "https://api-eu-central-1.graphcms.com/v2/ckbuiu23i00xo01z1dcb951t1/master",
  );


  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: httpLink,
    );
  }
}
