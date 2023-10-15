// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todo_example/core/provider/core_provider.dart';
//
// class TodoItem extends ConsumerWidget {
//   const TodoItem({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final todo = ref.watch(currentTodoProvider);
//     final itemFocusNode = FocusNode();
//     itemFocusNode.addListener(() => setState());
//     final itemIsFocused = itemFocusNode.hasFocus;
//
//     final textEditingController = TextEditingController();
//     final textFieldFocusNode = FocusNode();
//
//     return Material(
//       color: Colors.white,
//       elevation: 6,
//       child: Focus(
//         focusNode: itemFocusNode,
//         onFocusChange: (focused) {
//           if (focused) {
//             textEditingController.text = todo.description;
//           } else {
//             ref
//                 .read(todoListProvider.notifier)
//                 .edit(id: todo.id, description: textEditingController.text);
//           }
//         },
//         child: ListTile(
//           onTap: () {
//             itemFocusNode.requestFocus();
//             textFieldFocusNode.requestFocus();
//           },
//           leading: Checkbox(
//             value: todo.completed,
//             onChanged: (value) =>
//                 ref.read(todoListProvider.notifier).toggle(todo.id),
//           ),
//           title: itemIsFocused
//               ? TextField(
//             autofocus: true,
//             focusNode: textFieldFocusNode,
//             controller: textEditingController,
//           )
//               : Text(todo.description),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_example/core/provider/core_provider.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key});

  @override
  State<StatefulWidget> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  _TodoItemState();
  bool itemIsFocused = false;

  late final itemFocusNode;
  late final textFieldFocusNode;
  late final textEditingController;

  @override
  void initState() {
    super.initState();
    itemFocusNode = FocusNode();
    textFieldFocusNode = FocusNode();
    textEditingController = TextEditingController();
    itemFocusNode.addListener(() => setState(() {
          itemIsFocused = itemFocusNode.hasFocus;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, widget) {
      final todo = ref.watch(currentTodoProvider);

      return Material(
        color: Colors.white,
        elevation: 6,
        child: Focus(
          focusNode: itemFocusNode,
          onFocusChange: (focused) {
            if (focused) {
              textEditingController.text = todo.description;
            } else {
              ref
                  .read(todoListProvider.notifier)
                  .edit(id: todo.id, description: textEditingController.text);
            }
          },
          child: ListTile(
            onTap: () {
              itemFocusNode.requestFocus();
              textFieldFocusNode.requestFocus();
            },
            leading: Checkbox(
              value: todo.completed,
              onChanged: (value) =>
                  ref.read(todoListProvider.notifier).toggle(todo.id),
            ),
            title: itemIsFocused
                ? TextField(
                    autofocus: true,
                    focusNode: textFieldFocusNode,
                    controller: textEditingController,
                  )
                : Text(todo.description),
          ),
        ),
      );
    });
  }
}
