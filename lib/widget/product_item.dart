import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title,imageURL;
  UserProductItem(this.title, this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageURL),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: (){

              },
                  icon: const Icon(Icons.edit)),
              IconButton(
                color: Theme.of(context).errorColor,
                  onPressed: (){
              },
                  icon: const Icon(Icons.delete)),

            ],
          ),
        ),
      ),
    );
  }
}
