import Foundation
struct Task: Identifiable, Codable {
    var id = UUID()
    var title: String
    var completed: Bool = false
}



