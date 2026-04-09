import Foundation
import SwiftUI

struct StudentClass: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var assignments: [Assignment] = []
    var notebooks: [Notebook] = []
    var books: [Book] = []
    var notes: [Note] = []
    
    static func == (lhs: StudentClass, rhs: StudentClass) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Assignment: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var dueDate: Date
}

struct Notebook: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var attachedFileName: String?
}

struct Book: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var attachedFileName: String?
}

struct Note: Identifiable, Equatable {
    let id = UUID()
    var content: String
    var attachedFileName: String?
}
