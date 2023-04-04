//
//  ListRowView.swift
//  FirebaseToDo
//
//  Created by Jeremy Jackman on 3/6/23.
//

import SwiftUI
import Firebase
import FirebaseCore

struct ListRowView: View {
    let taskItem: TaskItemModel
    var body: some View {
        HStack {
            Image(systemName: taskItem.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(taskItem.isCompleted ? .green : .red)
            Text(taskItem.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var taskItem1 = TaskItemModel(title: "First Item", isCompleted: true)
    static var taskItem2 = TaskItemModel(title: "Second Item", isCompleted: false)
    
    static var previews: some View {
        Group {
            ListRowView(taskItem: taskItem1)
            ListRowView(taskItem: taskItem2)
        }
        .previewLayout(.sizeThatFits)
    }
}
