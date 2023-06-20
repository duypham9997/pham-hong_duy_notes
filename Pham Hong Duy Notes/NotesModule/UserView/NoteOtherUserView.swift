//
//  NoteOtherUserView.swift
//  Pham Hong Duy Notes
//
//  Created by PHAM HONG DUY on 6/19/23.
//

import SwiftUI

struct NoteOtherUserView: View {
    
    // MARK: - Declaration
    @ObservedObject var noteViewModel: NoteViewModel // khi viewModel thay đổi SwiftUI sẽ auto update UI
    let user: User
    
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
            .navigationTitle("Ghi chú của \(user.userName)")
            .navigationBarItems(leading: buttonBack)
            .onAppear {
                noteViewModel.getNotes()
            }
        }
    }
    
    private var buttonBack: some View {
        Button {
            // action back
        } label: {
            Image(systemName: "plus")
        }
    }
}

struct NoteOtherUserView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = NoteViewModel()
        let user = User(userUUID: "", userName: "")
        NoteOtherUserView(noteViewModel: viewModel, user: user)
    }
}
