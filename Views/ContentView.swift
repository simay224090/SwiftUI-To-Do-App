import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTask: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Yeni görev gir...", text: $newTask)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Ekle") {
                        if !newTask.isEmpty {
                            viewModel.addTask(title: newTask)
                            newTask = ""
                        }
                    }
                }
                .padding()
                
                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .onTapGesture {
                                    viewModel.toggleTaskCompletion(task)
                                }
                            Text(task.title).strikethrough(task.isCompleted)
                        }
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
            }
            .navigationTitle("To Do List").onAppear
            {
                viewModel.loadTasks()
            }
        }
    }
    

}

#Preview {
    ContentView()
}

