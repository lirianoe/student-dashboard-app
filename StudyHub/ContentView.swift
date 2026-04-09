import SwiftUI

struct ContentView: View {
    @StateObject var vm = StudyHubViewModel()
    @State private var showingAddClass = false
    @State private var newClassName = ""

    var body: some View {
        TabView {
            NavigationStack {
                List {
                    Section {
                        ForEach($vm.classes) { $studentClass in
                            NavigationLink(destination: DynamicClassDetailView(studentClass: $studentClass)) {
                                HStack {
                                    Image(systemName: "folder.fill").foregroundColor(.purple)
                                    Text(studentClass.name).font(.headline)
                                }
                                .padding(.vertical, 8)
                            }
                        }
                    } header: { Text("My Courses") }
                }
                .navigationTitle("StudyHub")
                .preferredColorScheme(.dark)
                .toolbar {
                    Button(action: { showingAddClass.toggle() }) {
                        Image(systemName: "plus.circle.fill").foregroundColor(.purple)
                    }
                }
                .alert("New Class", isPresented: $showingAddClass) {
                    TextField("Class Name", text: $newClassName)
                    Button("Add") {
                        if !newClassName.isEmpty {
                            vm.addClass(name: newClassName)
                            newClassName = ""
                        }
                    }
                    Button("Cancel", role: .cancel) { }
                }
            }
            .tabItem { Label("Hub", systemImage: "house.fill") }
            
            CalendarView(vm: vm)
                .tabItem { Label("Schedule", systemImage: "calendar") }
        }
        .tint(.purple)
    }
}

struct DynamicClassDetailView: View {
    @Binding var studentClass: StudentClass
    @State private var activeTab = 0
    @State private var showingAddSheet = false
    @State private var showingFilePicker = false
    
    @State private var titleInput = ""
    @State private var dateInput = Date()
    @State private var lastImportedFilename: String?

    var body: some View {
        VStack(spacing: 0) {
            Picker("", selection: $activeTab) {
                Text("Assignments").tag(0)
                Text("Books").tag(1)
                Text("Notebook").tag(2)
                Text("Notes").tag(3)
            }
            .pickerStyle(.segmented)
            .padding()

            List {
                if activeTab == 0 {
                    ForEach(studentClass.assignments) { item in
                        HStack {
                            Image(systemName: "checkmark.circle").foregroundColor(.purple)
                            Text(item.title)
                            Spacer()
                            Text(item.dueDate.formatted(date: .abbreviated, time: .omitted)).font(.caption2)
                        }
                    }
                } else if activeTab == 1 {
                    ForEach(studentClass.books) { item in
                        HStack {
                            Image(systemName: "book.fill").foregroundColor(.orange)
                            VStack(alignment: .leading) {
                                Text(item.title).bold()
                                if let file = item.attachedFileName { Label(file, systemImage: "doc").font(.caption).foregroundColor(.green) }
                            }
                        }
                    }
                } else if activeTab == 2 {
                    ForEach(studentClass.notebooks) { item in
                        HStack {
                            Image(systemName: "notebook.fill").foregroundColor(.blue)
                            VStack(alignment: .leading) {
                                Text(item.name).bold()
                                if let file = item.attachedFileName { Label(file, systemImage: "paperclip").font(.caption) }
                            }
                        }
                    }
                } else {
                    ForEach(studentClass.notes) { item in
                        VStack(alignment: .leading) {
                            Text(item.content).padding(8).background(Color.purple.opacity(0.1)).cornerRadius(8)
                            if let file = item.attachedFileName { Label(file, systemImage: "paperclip").font(.caption2) }
                        }
                    }
                }
            }
        }
        .navigationTitle(studentClass.name)
        .toolbar {
            Button { showingAddSheet = true } label: { Image(systemName: "plus") }
        }
        .sheet(isPresented: $showingAddSheet) {
            NavigationStack {
                Form {
                    Section("Details") {
                        TextField("Title / Content", text: $titleInput, axis: .vertical)
                        if activeTab == 0 {
                            DatePicker("Due Date", selection: $dateInput, displayedComponents: .date)
                        }
                    }
                    Section("Attachments") {
                        Button(action: { showingFilePicker = true }) {
                            Label(lastImportedFilename ?? "Tap to Upload File", systemImage: "doc.badge.plus")
                        }
                    }
                }
                .navigationTitle("Add Item")
                .toolbar {
                    Button("Save") {
                        saveData()
                        showingAddSheet = false
                        titleInput = ""; lastImportedFilename = nil
                    }
                }
                // THE ACTUAL FILE PICKER LOGIC
                .fileImporter(isPresented: $showingFilePicker, allowedContentTypes: [.pdf, .plainText, .image]) { result in
                    switch result {
                    case .success(let url):
                        self.lastImportedFilename = url.lastPathComponent
                    case .failure(let error):
                        print("Error picking file: \(error.localizedDescription)")
                    }
                }
            }
            .presentationDetents([.medium])
        }
    }

    func saveData() {
        switch activeTab {
        case 0: studentClass.assignments.append(Assignment(title: titleInput, dueDate: dateInput))
        case 1: studentClass.books.append(Book(title: titleInput, attachedFileName: lastImportedFilename))
        case 2: studentClass.notebooks.append(Notebook(name: titleInput, attachedFileName: lastImportedFilename))
        case 3: studentClass.notes.append(Note(content: titleInput, attachedFileName: lastImportedFilename))
        default: break
        }
    }
}
