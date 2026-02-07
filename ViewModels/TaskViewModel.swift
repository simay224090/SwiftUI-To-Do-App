//
//  TaskViewModel.swift
//  MyFirstProject
//
//  Created by Simay Çalışkan on 7.02.2026.
//
import Foundation
import Combine
import SwiftUI

class TaskViewModel: ObservableObject {
    
 @Published var tasks: [TaskItem] = []
    
    let saveKey: String = "to-do-tasks"
    
    
    
    func addTask(title: String) {
        
        let task = TaskItem(id: UUID(), title: title, isCompleted: false)
        tasks.append(task)
        saveTask(tasks)
    }
    
    func deleteTask(at offset: IndexSet) {
        tasks.remove(atOffsets: offset)
        saveTask(tasks)
        
    }
    
    func toggleTaskCompletion(_ task: TaskItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            saveTask(tasks)
        }
        
    }
    
    func saveTask(_ tasks: [TaskItem]) {
        UserDefaults.standard.set(try? JSONEncoder().encode(tasks), forKey: saveKey)
      
    }
   
        
    func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
        let savedTasks = try? JSONDecoder().decode([TaskItem].self, from: data) {
                tasks = savedTasks
            }
        }

    }

    
