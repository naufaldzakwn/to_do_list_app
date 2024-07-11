import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/api_service.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];
  bool _isLoading = false;

  List<Todo> get todos => _todos;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  TodoProvider() {
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    _isLoading = true;
    notifyListeners();

    try {
      _todos = await _apiService.fetchTodos();
    } catch (error) {
      // Handle error appropriately
      print('Error fetching todos: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }
}
