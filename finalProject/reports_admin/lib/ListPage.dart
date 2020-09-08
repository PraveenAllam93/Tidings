import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'DetailsPage.dart';

class ListPage extends StatefulWidget {

  
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getPosts() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn  = await firestore.collection("Reports").getDocuments();
    return qn.documents;

  }
  navigateToDetail(DocumentSnapshot post){
    Navigator.push(context,MaterialPageRoute(builder: (context) => DetailsPage(post: post,)));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getPosts(),
        builder: ( _ ,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child : Text("Loading...."));
        }
        else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: ( _ ,index){
              if(! snapshot.hasData){
                return new Text('No Reports!');
              }
              
              return Container(
                
                child: Card(
                  child: ListTile(
                    title: Text(snapshot.data[index].data["ClubName"]),
                    
                    subtitle: Text(snapshot.data[index].data["Description"]),
                    trailing: Text(snapshot.data[index].data["Month"]),
                    onTap: () { navigateToDetail(snapshot.data[index]);
                    
                    }
                  )
                )
              );

          });


        }

      }),
      
    );
  }
}