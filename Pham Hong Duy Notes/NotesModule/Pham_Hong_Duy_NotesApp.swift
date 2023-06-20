//
//  Pham_Hong_Duy_NotesApp.swift
//  Pham Hong Duy Notes
//
//  Created by PHAM HONG DUY on 6/19/23.
//

import SwiftUI
import Firebase

@main
struct Pham_Hong_Duy_NotesApp: App {
    
    init() { // configure Firebase khi vào app nếu như không muốn bị lỗi kết nối
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
