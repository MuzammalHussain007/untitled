import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:untitled/providers/product_provider.dart';
import 'package:untitled/widget/update_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title,imageURL , id;
  UserProductItem(this.id,this.title, this.imageURL);


  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
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
                    Navigator.of(context).pushNamed(UpdateProductScreen.routeName,arguments: id);
              },
                  icon: const Icon(Icons.edit)),
              IconButton(
                color: Theme.of(context).errorColor,
                  onPressed: () async {
                  try
                  {
                  await context.read<Product_provider>().deleteProduct(id);
                  }
                  catch(error)
                    {
                      scaffold.showSnackBar(
                       const SnackBar(content: Text('Could not Deleted Product',textAlign: TextAlign.center,))
                     );
                    }

              },
                  icon: const Icon(Icons.delete)),

            ],
          ),
        ),
      ),
    );
  }
}
