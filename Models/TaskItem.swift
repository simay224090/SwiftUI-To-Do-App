//
//  TaskItem.swift
//  MyFirstProject
//
//  Created by Simay Çalışkan on 7.02.2026.
//
import Foundation

struct TaskItem:Identifiable,Codable {
    
    let id:UUID
    var title:String
    var isCompleted:Bool
    
}
