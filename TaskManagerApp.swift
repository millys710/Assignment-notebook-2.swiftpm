import SwiftUI
@main
struct TaskManagerApp: App {
    @StateObject private var taskData = TaskData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(taskData)
                .onAppear {
                    taskData.loadTasks()
                }
        }
    }
}
class TaskData: ObservableObject {
    @Published var tasks: [Task] = []
    func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: "tasks") {
            if let decoded = try? JSONDecoder().decode([Task].self, from: data) {
                tasks = decoded
                return
            }
        }
        tasks = []
    }
}



