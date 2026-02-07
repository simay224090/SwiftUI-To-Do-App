import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = TaskViewModel()
    @State private var newTask: String = ""
    @State private var showCelebration = false
    
    @State private var editingTaskID: UUID? = nil
    @State private var editedTitle: String = ""


    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                // Başlık
                Text("To Do List")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                // TextField + Button
                HStack {
                    TextField("Yeni görev gir...", text: $newTask)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    
                    Button {
                        if !newTask.isEmpty {
                            viewModel.addTask(title: newTask)
                            newTask = ""
                        }
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.accentColor)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                // Liste
                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .gray)
                                .onTapGesture {
                                    viewModel.toggleTaskCompletion(task)
                                }

                            if editingTaskID == task.id {
                                TextField("Görev", text: $editedTitle, onCommit: {
                                    viewModel.updateTask(task: task, newTitle: editedTitle)
                                    editingTaskID = nil
                                })
                                .textFieldStyle(.roundedBorder)
                            } else {
                                Text(task.title)
                                    .strikethrough(task.isCompleted)
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button("Düzenle") {
                                editingTaskID = task.id
                                editedTitle = task.title
                            }
                            .tint(.orange)
                        }
                    }
                    .onDelete(perform: viewModel.deleteTask)

                    .onDelete(perform: viewModel.deleteTask)
                }
                .listStyle(.plain)
                if showCelebration {
                    VStack {
                        Text("Tebrikler! Tüm görevler tamamlandı 🎉")
                            .font(.headline)
                    }
                    .padding()
                }

            }
            .onAppear {
                viewModel.loadTasks()
            }
            .onChange(of: viewModel.tasks) {
                showCelebration = viewModel.allTasksCompleted
            }


        }
    }
}

#Preview {
    ContentView()
}


