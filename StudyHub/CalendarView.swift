import SwiftUI

struct CalendarView: View {
    @ObservedObject var vm: StudyHubViewModel
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("Schedule", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .tint(.purple)
                    .padding()
                
                List {
                    Section("Deadlines") {
                        let filtered = vm.classes.flatMap { $0.assignments }.filter {
                            Calendar.current.isDate($0.dueDate, inSameDayAs: selectedDate)
                        }
                        
                        if filtered.isEmpty {
                            Text("No deadlines today").italic().foregroundColor(.secondary)
                        } else {
                            ForEach(filtered) { task in
                                Label(task.title, systemImage: "bell.fill").foregroundColor(.purple)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Schedule")
        }
    }
}
