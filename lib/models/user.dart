import 'package:meta/meta.dart';


class
Address {
   final String street;
   final String suite;
   final String city;
   final String zipcode;


   Address({
      @required this.street
      , @required this.suite
      , @required this.city
      , @required this.zipcode
   });
}


class
Company {
   final String name;
   final String catchPhrase;
   final String bs;


   Company({
      @required this.name
      , @required this.catchPhrase
      , @required this.bs
   });
}


class
UserModel {
   final int userId;
   final String userName;
   final String name;
   final String email;
   final String phone;
   final String website;
   final Address address;
   final Company company;


   factory
   UserModel.fromJson(Map<String, dynamic> v) {
      return new UserModel._(
         userId: v['id']
         , userName: v['username']
         , name: v['name']
         , email: v['email']
         , phone: v['phone']
         , website: v['website']
         , address: new Address(
            street: v['address']['street']
            , suite: v['address']['suite']
            , city: v['address']['city']
            , zipcode: v['address']['zipcode']
         )
         , company: new Company(
            name: v['company']['name']
            , catchPhrase: v['company']['catchPhrase']
            , bs: v['company']['bs']
         )
      );
   }


   UserModel._({
      @required this.userId
      , @required this.userName
      , @required this.name
      , @required this.email
      , @required this.phone
      , @required this.website
      , @required this.address
      , @required this.company
   });
}
