//
//  NoteViewModel.swift
//  Pham Hong Duy Notes
//
//  Created by PHAM HONG DUY on 6/19/23.
//

import Foundation
import SwiftUI
import FirebaseDatabase
import Firebase

class NoteViewModel: ObservableObject { // ViewModel cho ghi chú
    
    // MARK: - Declaration
    @Published var notes: [Note] = [] // observale giám sát thay đổi của notes
    @Published var listUser: [User] = []
    private let userUUID: String? = UserDefaults.standard.string(forKey: "userUUIDKey") // Dùng UserDefaults để kiểm tra user
    private let dbFireBase = Database.database().reference() // db của firebase
    private let userKey = "user" // const key cho user
    private let notesKey = "notes" // const key cho notes

    // MARK: - Functions
    
    func getNotes() { // lấy danh sách các note của user chính chủ
        dbFireBase.child(userKey).child(userUUID ?? "").child(notesKey).observe(.value) { data, error in
            
            if let error = error {
                print("Error getNotes \(error)")
                return
            }
            
            guard let noteRes = data.value as? [String:[String:Any]] else { return }
            
            self.notes = noteRes.compactMap({ (key, value) in
                guard let title = value["title"] as? String,
                let content = value["content"] as? String
                else { return nil }
                
                return Note(id: key, title: title, content: content)
            })
        }
    }
    
    func addNote(title: String, content: String) { // thêm 1 notes vào firebase vo
        let note: [String : String] = [
            "title": title,
            "content": content
        ]
        
        let userNoteRef = dbFireBase.child(userKey).child(userUUID ?? "")
        let noteRef = userNoteRef.child(notesKey).childByAutoId()

        noteRef.setValue(note) { error, _ in
            print("Error addNote \(String(describing: error))")
        }
    }
    
    func getAllUserInDatabase() { // lấy tất cả user lưu trong database
        dbFireBase.child(userKey).observe(.value) { [weak self] data, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error getAllUserInDatabase \(error)")
                return
            }
            
            var userList : [User] = []
            data.children.forEach { child in
                if let childData = child as? DataSnapshot,
                   let userData = childData.value as? [String : Any],
                   let userName = userData["userName"] as? String,
                   let userUUID = userData["userUUID"] as? String
                {
                    if userUUID == self.userUUID {
                        return
                    }
                    let user = User(userUUID: userUUID,userName: userName)
                    userList.append(user)
                }
            }
            
            self.listUser = userList
        }
    }
}
