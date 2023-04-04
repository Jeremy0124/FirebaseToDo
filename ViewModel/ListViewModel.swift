//
//  ListViewModel.swift
//  FirebaseToDo
//
//  Created by Jeremy Jackman on 3/7/23.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore

class ListViewModel: ObservableObject {
    
    @Published var taskItems: [TaskItemModel] = []
    
    func deleteData(deleteItemToDelete : TaskItemModel) {
        let db = Firestore.firestore()
        
        db.collection("taskItems").document(deleteItemToDelete.id).delete() { error in
            if let error = error {
                print("🚨 Error Deleting Document \(error) 🚨")
            } else {
                print("🗑️ Document deleted 🗑️")
                
            }
        }
    }
    
    func updateIsCompleted(taskItemsUpdate: TaskItemModel) {
        let db = Firestore.firestore()
        
        db.collection("taskItems").document(taskItemsUpdate.id).setData(["title" : "\(taskItemsUpdate.title)", "isCompleted": !taskItemsUpdate.isCompleted], merge: true)
        
        print("🟨 This Task is Completed! 🟨")
    }
    
    func updateTitle(taskItemsUpdate: TaskItemModel) {
        let db = Firestore.firestore()
        
        db.collection("taskItems").document("\(taskItemsUpdate.id)").setData(["title" : "\(taskItemsUpdate.title)", "isCompleted": false], merge: false)
        
        print("✍️ Title should have changed ✍️")
    }
    
    func moveItem(from: IndexSet, to: Int) {
        taskItems.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let db = Firestore.firestore()
        
        db.collection("taskItems").addDocument(data: [
            "title":title,
            "isCompleted": false
        ]) { error in
            if let error = error {
                print("🚨 \(error) 🚨")
            } else {
                print("✅ Document added ✅")
            }
            
        }
    }
    
    func fetchData() {
        let db = Firestore.firestore()
        
        db.collection("taskItems").getDocuments { snapshot, error in
            
            // Checks for errors
            if error == nil {
                DispatchQueue.main.async {
                    // if No errors happens we want this line of code to retrieve the documents
                    if let snapshot = snapshot {
                        
                        // taskItems <- is the collections name
                        self.taskItems = snapshot.documents.map { data in
                            
                            // decoding the TaskItemModel and since that happens we have to manually assign it's type and default value in the event it does not know what value is is
                            return TaskItemModel(id: data.documentID,
                                                 title: data["title"] as? String ?? "🚫 NO AVAILABLE DATA 🚫",
                                                 isCompleted: data["isCompleted"] as? Bool ?? false)
                        }
                    } 
                }
            } else {
                print("🚫🔥 No connection to Firebase Database 🚫🔥")
            }
        }
    }
    

}
