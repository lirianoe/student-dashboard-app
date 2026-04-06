import SwiftUI

struct ClassModel: Identifiable {
    let id = UUID()
    var name: String
    var notes: [String]
}

struct ContentView: View {
    
    @State private var classes: [ClassModel] = []
    @State private var newClassName = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    TextField("Enter class name", text: $newClassName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Add") {
                        if !newClassName.isEmpty {
                            classes.append(ClassModel(name: newClassName, notes: []))
                            newClassName = ""
                        }
                    }
                }
                .padding()
                
                List {
                    ForEach(classes) { classItem in
                        NavigationLink(destination: ClassDetailView(classItem: classItem)) {
                            Text(classItem.name)
                        }
                    }
                }
            }
            .navigationTitle("My Classes")
        }
    }
}

struct ClassDetailView: View {
    var classItem: ClassModel
    @State private var newNote = ""
    @State private var notes: [String] = []
    
    var body: some View {
        VStack {
            
            HStack {
                TextField("New note", text: $newNote)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Add") {
                    if !newNote.isEmpty {
                        notes.append(newNote)
                        newNote = ""
                    }
                }
            }
            .padding()
            
            List(notes, id: \.self) { note in
                Text(note)
            }
        }
        .navigationTitle(classItem.name)
    }
}
