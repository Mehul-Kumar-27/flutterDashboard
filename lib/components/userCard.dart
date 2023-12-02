import 'package:admin/constants.dart';
import 'package:admin/models.dart';
import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  final User user;
  final bool isSelected;
  final ValueChanged<bool?> onCheckboxChanged;
  final VoidCallback? onDelete;

  const UserCard({
    Key? key,
    required this.user,
    required this.isSelected,
    required this.onCheckboxChanged,
    this.onDelete,
  }) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double currentFont = MediaQuery.of(context).textScaleFactor;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width * 0.17,
              child: Row(
                children: [
                  Checkbox(
                    value: widget.isSelected,
                    onChanged: widget.onCheckboxChanged,
                  ),
                  SizedBox(
                    width: width * 0.007,
                  ),
                  isEditing
                      ? SizedBox(
                          width: width * 0.1,
                          child: TextField(
                            controller: _nameController,
                            style: TextStyle(
                                overflow: TextOverflow.fade,
                                color: Colors.white70,
                                fontSize: currentFont * 16),
                          ),
                        )
                      : Text(
                          widget.user.name!,
                          style: TextStyle(
                              overflow: TextOverflow.fade,
                              color: Colors.white70,
                              fontSize: currentFont * 16),
                        ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isEditing
                      ? SizedBox(
                          width: width * 0.1,
                          child: TextField(
                            controller: _emailController,
                            style: TextStyle(
                                overflow: TextOverflow.fade,
                                color: Colors.white70,
                                fontSize: currentFont * 15),
                          ),
                        )
                      : Text(
                          widget.user.email!,
                          style: TextStyle(
                              overflow: TextOverflow.fade,
                              color: Colors.white70,
                              fontSize: currentFont * 15),
                        ),
                  SizedBox(
                    width: width * 0.007,
                  )
                ],
              ),
            ),
            Text(
              widget.user.role!,
              style: TextStyle(
                color: Colors.white70,
                fontSize: currentFont * 15,
                overflow: TextOverflow.fade,
              ),
            ),
            SizedBox(
              width: width * 0.065,
              height: height * 0.04,
              child: Row(
                children: [
                  IconButton(
                    hoverColor: secondaryColor,
                    onPressed: () {
                      setState(() {
                        if (isEditing) {
                          // Save changes
                          widget.user.name = _nameController.text;
                          widget.user.email = _emailController.text;
                          isEditing = false;
                        } else {
                          // Start editing
                          _nameController.text = widget.user.name!;
                          _emailController.text = widget.user.email!;
                          isEditing = true;
                        }
                      });
                    },
                    icon: Icon(
                      isEditing ? Icons.save : Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    hoverColor: secondaryColor,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm Deletion"),
                            content: Text(
                                "Are you sure you want to delete ${widget.user.name}?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  widget.onDelete!();
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Confirm"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
