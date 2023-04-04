//
//  taskItemModel.swift
//  FirebaseToDo
//
//  Created by Jeremy Jackman on 3/7/23.
//

import Foundation

struct TaskItemModel: Identifiable {
    var id: String = UUID().uuidString
    let title: String
    let isCompleted: Bool

}
