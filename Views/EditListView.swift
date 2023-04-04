//
//  EditListView.swift
//  FirebaseToDo
//
//  Created by Jeremy Jackman on 3/20/23.
//

import SwiftUI

struct EditListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var selectedTaskItem: TaskItemModel?
    @State var title: String = ""
    @State var taskItem_ID: String = ""
    
    init(passedTaskItem: TaskItemModel?) {
        if let taskItems = passedTaskItem {
            _title = State(initialValue: "\(taskItems.title)")
            _taskItem_ID = State(initialValue: "\(taskItems.id)")
            selectedTaskItem = passedTaskItem
        } else {
            _title = State(initialValue: "NO PASSED TASKITEM")
        }
    }
    
    var body: some View {
        
        TextField("Update Task...", text: $title)
            .padding(.horizontal)
            .frame(height: 55)
            .background(Color(UIColor.lightGray))
            .cornerRadius(25)
        
        Button(action: editSaveButtonPressed, label: {
            Text("Update".uppercased())
                .foregroundColor(Color.white)
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.green)
        })
        
        Button(action: test, label: {
            Text("Test".uppercased())
                .foregroundColor(Color.white)
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.green)
        })
   
    }
    
    func test() {
        print("⭐️ \(title) ⭐️")
        print("⭐️ \(taskItem_ID) ⭐️")
    }
    
        func editSaveButtonPressed() {
            if textIsAppropriate() {
                
                listViewModel.updateTitle(taskItemsUpdate: selectedTaskItem ?? TaskItemModel(id: taskItem_ID, title: title, isCompleted: false))
                presentationMode.wrappedValue.dismiss()
                
                print("🟦 \((title)) 🟦")
                print("🟦 \((taskItem_ID)) 🟦")
            }
        }
        
        func textIsAppropriate() -> Bool {
            if title.count < 2 {
                return false
            } else {
                return true
            }
        }
    }

struct EditListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            EditListView(passedTaskItem: TaskItemModel(title: "" , isCompleted: false))
        }
        .environmentObject(ListViewModel())
    }
}
