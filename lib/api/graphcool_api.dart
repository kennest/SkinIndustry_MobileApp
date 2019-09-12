import 'package:graphql/client.dart';
import '../graphql/queries.dart';
import 'dart:convert';
class GraphCoolApi{

  var _result=QueryResult();
  final GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: HttpLink(
        uri: 'https://api.graph.cool/simple/v1/ck0fi8hgg78ch0131fnq9deyx',
        headers: {'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NjgyMjE4NzksImNsaWVudElkIjoiY2swY2NzandpNDBidDAxNjM3ajVrdXJ1dyIsInByb2plY3RJZCI6ImNrMGZpOGhnZzc4Y2gwMTMxZm5xOWRleXgiLCJwZXJtYW5lbnRBdXRoVG9rZW5JZCI6ImNrMGZpdGVocDAzamkwMTYxc3Z5bmFobWMifQ.okHlvEPhlv6LX4Sep0nxC5H8REz8qNo9E5vnkohO57o'}
    ),
  );



   void addCategory(String label) async{
     MutationOptions options = MutationOptions(
       document: createCategory,
       variables: <String, dynamic>{
         'label': label,
       },
     );
     _result = await _client.mutate(options);
     if (_result.hasErrors) {
       print("GraphQl Error => ${_result.errors}");
     }else{
       print("GraphQl Data => ${_result.data.toString()}");
     }
   }

  void getAllCategories() async{
    QueryOptions options = QueryOptions(
      document: AllCategories,
    );
    _result = await _client.query(options);
    if (_result.hasErrors) {
      print("GraphQl Error => ${_result.errors}");
    }else{
      print("GraphQl Data => ${_result.data.toString()}");
      print("GraphQl Data JSON=> ${json.decode(_result.data.toString())}");
    }
  }

}