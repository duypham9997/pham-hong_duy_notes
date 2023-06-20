//
//  NoteListView.swift
//  Pham Hong Duy Notes
//
//  Created by PHAM HONG DUY on 6/19/23.
//

import SwiftUI

struct NoteListView: View { // hiển thị danh sách ghi chú, cho phép người dùng tạo và xóa ghi chú
    
    // MARK: - Declaration
    @ObservedObject var noteViewModel: NoteViewModel // nó quan sát các đối tượng trong ObservableObject model, theo dõi sự thay đổi và update
    @State private var newNoteTitle: String = "" // thuộc tính lưu trữ trên UI, khi thay đổi swiftUI sẽ auto update, chỉ dùng trên struct
    @State private var newNoteContent: String = ""
    @State private var addNewNoteActive: Bool = false // nhan add = true, hide = false
    @State private var userModal: Bool = false // nhan add = true, hide = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List(noteViewModel.notes) { note in
                VStack(alignment: .leading) {
                    Text(note.title)
                        .font(.headline)
                    Text(note.content)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            } // show 1 list danh sách note với 2 text
            .navigationTitle("Ghi chú của bạn")
            .navigationBarItems(trailing: buttonAdd)
            .navigationBarItems(leading: buttonOtherUser)
            .onAppear {
                noteViewModel.getNotes() 
            }
        }
        
    }
    
    // MARK: - Action
    private var buttonAdd: some View { // button hiển thị modal AddNote
        Button {
            addNewNoteActive = true
        } label: {
            Image(systemName: "plus")
        }
        .sheet(isPresented: $addNewNoteActive) {
            AddNoteModal(isShowingModal: $addNewNoteActive, newNoteTitle: $newNoteTitle, newNoteContent: $newNoteContent) {
                noteViewModel.addNote(title: newNoteTitle, content: newNoteContent)
            }
        }
    }
    
    private var buttonOtherUser: some View { // button hiển thị other user trong db
        Button {
            noteViewModel.getAllUserInDatabase()
            userModal = true
        } label: {
            Image(systemName: "person.circle")
        }
        .sheet(isPresented: $userModal) {
            UserModal(listUser: $noteViewModel.listUser, isShowingModal: $userModal, userResponse: { userResponse in
                // hiển thị notes theo UserUUID
            })
        }
    }
    
    
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = NoteViewModel()
        NoteListView(noteViewModel: viewModel)
    }
}
