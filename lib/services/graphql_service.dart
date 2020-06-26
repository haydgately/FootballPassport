import 'package:graphql/client.dart';

class GraphQLService {
  GraphQLClient _client;

  GraphQLService() {
    HttpLink link = HttpLink(uri: 'https://api-eu-central-1.graphcms.com/v2/ckbuiu23i00xo01z1dcb951t1/master');

    _client = GraphQLClient(link: link, cache: InMemoryCache());
  }

  Future<QueryResult> performQuery(String query,
      {Map<String, dynamic> variables}) async {
    QueryOptions options =
        QueryOptions(documentNode: gql(query), variables: variables);

    final result = await _client.query(options);

    return result;
  }

  Future<QueryResult> performMutation(String query,
      {Map<String, dynamic> variables}) async {
    MutationOptions options =
        MutationOptions(documentNode: gql(query), variables: variables);

    final result = await _client.mutate(options);

    print(result);

    return result;
  }
}
