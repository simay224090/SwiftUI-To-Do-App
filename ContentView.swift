import SwiftUI

struct ContentView: View {
    
    @State private var tasks: [String] = []
    @State private var newTask: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Yeni görev gir...", text: $newTask)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Ekle") {
                        if !newTask.isEmpty {
                            tasks.append(newTask)
                            newTask = ""
                        }
                    }
                }
                .padding()
                
                List {
                    ForEach(tasks, id: \.self) { task in
                        Text(task)
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .navigationTitle("To Do List")
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}

