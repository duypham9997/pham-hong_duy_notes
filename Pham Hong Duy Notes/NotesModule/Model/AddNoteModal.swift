//
//  AddNoteModal.swift
//  Pham Hong Duy Notes
//
//  Created by PHAM HONG DUY on 6/19/23.
//

import Foundation
import SwiftUI

struct AddNoteModal: View { // modal sheet hiển thị Textfield để thêm Note
    
    // MARK: - Declaration
    @Binding var isShowingModal: Bool // check hiển thị modal
    @Binding var newNoteTitle: String // giá trị của title note mới
    @Binding var newNoteContent: String // giá trị của content note mới
    
    // MARK: - Callback
    var addNote: () -> Void // call back NoteListView tiếp tục xử lí
    
    // MARK: - Declaration
    var body: some View {
        VStack {
            TextField("Title", text: $newNoteTitle)
                .padding()
            TextEditor(text: $newNoteContent)
                .padding()
                .frame(height: 300)
                .border(Color.blue)
            Button {
                addNote()
                isShowingModal = false // sau khi add notes và db thì reset lại giá trị
                newNoteTitle = ""
                newNoteContent = ""
            } label: {
                Text("Add new note")
            }
            .padding()
            .background(Color.yellow)
            .cornerRadius(8)
            .shadow(radius: 4)
            
            Spacer()
        }
        .padding()
    }
}
