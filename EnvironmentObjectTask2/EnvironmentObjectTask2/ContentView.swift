
import SwiftUI

class TaskManager: ObservableObject {
    @Published var tasks: [String] = []
}

struct RootView: View {
    @StateObject private var taskManager = TaskManager()
    
    var body: some View {
        VStack(spacing: 20) {
            TaskListView()
            AddTaskView()
            RemoveTaskView()
        }
        .padding()
        .environmentObject(taskManager)
    }
}

struct TaskListView: View {
    @EnvironmentObject var taskManager: TaskManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Tasks:")
                .font(.headline)
            List(taskManager.tasks, id: \.self) { task in
                Text(task)
            }
        }
    }
}

struct AddTaskView: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var newTask: String = ""
    
    var body: some View {
        HStack {
            TextField("New Task", text: $newTask)
                .textFieldStyle(.roundedBorder)
            Button("Add") {
                guard !newTask.isEmpty else { return }
                taskManager.tasks.append(newTask)
                newTask = ""
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct RemoveTaskView: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var indexToRemove: String = ""
    
    var body: some View {
        HStack {
            TextField("Index to Remove", text: $indexToRemove)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
            Button("Remove") {
                if let index = Int(indexToRemove),
                   index >= 0,
                   index < taskManager.tasks.count {
                    taskManager.tasks.remove(at: index)
                    indexToRemove = ""
                }
            }
            .buttonStyle(.bordered)
        }
    }
}


