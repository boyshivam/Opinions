import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class EditPostPopUp extends StatelessWidget {
   EditPostPopUp({
    super.key,
    required this.editTitleController,
    required this.editGenreController,
    required this.editContextController,
  });

  final TextEditingController editTitleController;
  final TextEditingController editGenreController;
  final TextEditingController editContextController;

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Center(child: Text("Edit post")),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  Text("Edit post title"),
                  TextFormField(
                    controller: editTitleController,
                    maxLength: 30,
                    decoration: InputDecoration(counterText: ""),
                    validator: (value) {
                      if (value == null) {
                        return "Value cannot be null";
                      }
                      if (value.trim().isEmpty) {
                        return "Title cannot be empty";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  Text("Edit genre"),
                  TextFormField(
                    controller: editGenreController,
                    maxLength: 30,
                    decoration: InputDecoration(counterText: ""),
                    validator: (value) {
                      if (value == null) {
                        return "Value cannot be null";
                      }
                      if (value.trim().isEmpty) {
                        return "genre cannot be empty";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  Text("Edit context"),
                  TextFormField(
                    controller: editContextController,
                    maxLength: 30,
                    decoration: InputDecoration(counterText: ""),
                    validator: (value) {
                      if (value == null) {
                        return "Value cannot be null";
                      }
                      if (value.trim().isEmpty) {
                        return "context cannot be empty";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: (){
                  context.pop();
                }, child: Text("Cancel")),
                ElevatedButton(onPressed: (){}, child: Text("Submit"))

              ],
            )
          ],
        ),
      ),
    );
  }
}
