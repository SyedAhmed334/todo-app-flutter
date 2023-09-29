class TaskController {
  final String taskName;
  final String priority;
  bool isDone;
  TaskController(
      {required this.taskName, required this.priority, this.isDone = false});
}
