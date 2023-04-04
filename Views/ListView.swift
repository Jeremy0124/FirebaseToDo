//
//  ContentView.swift
//  FirebaseToDo
//
//  Created by Jeremy Jackman on 3/2/23.
//

import SwiftUI
import Firebase
import FirebaseCore

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        List(listViewModel.taskItems) { taskItem in
            HStack {
                    Image(systemName: taskItem.isCompleted ? "checkmark.seal.fill" : "clock.badge.questionmark.fill")
                        .foregroundColor(taskItem.isCompleted ? .green : .red)
                        .onTapGesture {
                            listViewModel.updateIsCompleted(taskItemsUpdate: taskItem)
                        }
                    Spacer()
                
                    Text(taskItem.title)
                    
                   
                NavigationLink(destination: EditListView(passedTaskItem: taskItem)) {
                        Image(systemName: "hammer")
                            .foregroundColor(Color.blue)
                            .padding(.trailing)
                    }
                    
                    Button(action: {
                        listViewModel.deleteData(deleteItemToDelete: taskItem)
                    }, label: {
                        Image(systemName: "trash")
                            .foregroundColor(Color.red)
                    })
                    .buttonStyle(BorderedButtonStyle())
                }
            .padding()
        }
        .refreshable {
            listViewModel.fetchData()
            print("🔄 View should be Updating 🔄")
        }

        .onAppear {
            listViewModel.fetchData()
        }
      
        .listStyle(PlainListStyle())
        .navigationTitle("Firebase ToDo List")
        .navigationBarItems(leading: EditButton(), trailing: NavigationLink("Add", destination: AddView())
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}


