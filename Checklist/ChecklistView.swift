//
//  ContentView.swift
//  Checklist
//
//  Created by Margo on 9/25/20.
//

import SwiftUI

struct ChecklistView: View {
    
    //  Properties
    //  ==========
    @ObservedObject var checklist = Checklist()
    @State var newChecklistItemViewIsVisible = false
    
    //  User interface content and layout
    //  =================================
    var body: some View {
        NavigationView {
            List {
                ForEach(checklist.items) { index in
                    RowView(checklistItem: self.$checklist.items[index])
                }
                .onDelete(perform: checklist.deleteListItem)
                .onMove(perform: checklist.moveListItem)
            }
            .navigationBarItems(leading: Button(action: {
                self.newChecklistItemViewIsVisible = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add item")
                }
                .foregroundColor(.red)
            },
            trailing: EditButton().foregroundColor(.red))
            
            .navigationBarTitle("Checklist")
            .onAppear() {
                self.checklist.printChecklistContents()
                self.checklist.saveListItems()
            }
        }
        .sheet(isPresented: $newChecklistItemViewIsVisible) {
            NewChecklistItemView(checklist: self.checklist)
        }
    }
    
    
    //  Methods
    //  =======
    
    
}


//  Preview
//  =======
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistView()
    }
}
