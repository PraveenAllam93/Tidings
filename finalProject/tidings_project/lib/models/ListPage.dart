import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tidings_project/models/DetailsPage.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getPosts() async{
    var firestore = Firestore.instance;
    QuerySnapshot qn  = await firestore.collection("Posts").getDocuments();
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

              return Container(
                child: Card(
                  child: ListTile(
                    title: Text(snapshot.data[index].data["ClubName"]),
                    
                    subtitle: Text(snapshot.data[index].data["Description"]),
                    trailing: Text(snapshot.data[index].data["Month"]),
                    onTap: () { navigateToDetail(snapshot.data[index]);
                    Fluttertoast.showToast(
                          msg: "Detailed View of selected Event!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );
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