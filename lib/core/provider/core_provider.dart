import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:todo_example/domain/model/todo.dart';
import 'package:todo_example/presentation/viewmodel/home_page_viewmodel.dart';

enum TodoListFilter {
  all,
  active,
  completed,
}

final addTodoKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();
final allFilterKey = UniqueKey();

final todoListProvider = NotifierProvider<HomePageViewModel, List<Todo>>(HomePageViewModel.new);
final todoListFilteredProvider = StateProvider((_) => TodoListFilter.all);
final currentTodoProvider = Provider<Todo>((ref) => throw UnimplementedError());
final uncompletedTodosCountProvider = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
});
final filteredTodosProvider = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilteredProvider);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoListFilter.all:
      return todos;
  }
});