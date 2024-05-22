import SwiftUI
struct ContentView: View {
    @State private var tasks: [Task] = []
    @State private var newTaskTitle = ""
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(tasks) { task in
                        Text(task.title)
                    }
                    .onDelete(perform: deleteTask)
                }
                .navigationTitle("Tasks")
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button(action: addTask) {
                        Image(systemName: "plus")
                    }
                )
                .padding()
                TextField("Enter new task", text: $newTaskTitle, onCommit: addTask)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
        }
    }
    func addTask() {
        if !newTaskTitle.isEmpty {
            let task = Task(title: newTaskTitle)
            tasks.append(task)
            saveTasks()
            newTaskTitle = ""
        }
    }
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTasks()
    }
    func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }
}
