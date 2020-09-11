import '../models/ground.dart';
import '../../services/graphql_service.dart';
import "package:flutter/material.dart";
import 'package:graphql/client.dart';

class GroundDataProvider {

  String getAll() {
    return """ 
      {
        visits {
          groundName
          homeTeam
        }
      }
    """;
  }

  String insertGroundQuery(groundName, homeTeam){
    return """  
      mutation MyMutation {
  __typename
  createVisit(data: {groundName: "TesterGround", homeTeam: "TesterTeam"}) {
    id
  }
}
    """;

  }

  void insertGround(groundName, homeTeam) async{
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        // ignore: deprecated_member_use
        document: insertGroundQuery("sdf", "sdf"),
      ),
    );
  }


  Future<List<Ground>> getGrounds() async {
    List<Ground> listGrounds = [];
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        // ignore: deprecated_member_use
        document: getAll(),
      ),
    );
    if (!result.hasException) {
      for (var i = 0; i < result.data["visits"].length; i++) {
        listGrounds.add(
          Ground(
            result.data["visits"][i]["groundName"],
            result.data["visits"][i]["homeTeam"],
          ),
        );
      }
      return listGrounds;
    }
  }
}
