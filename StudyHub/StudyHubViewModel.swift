import Foundation

class StudyHubViewModel: ObservableObject {
    @Published var classes: [StudentClass] = [
        StudentClass(name: "iOS Development", assignments: [
            Assignment(title: "Final Demo", dueDate: Date())
        ])
    ]
    
    func addClass(name: String) {
        classes.append(StudentClass(name: name))
    }
}
