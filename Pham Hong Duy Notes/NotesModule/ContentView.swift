//
//  ContentView.swift
//  Pham Hong Duy Notes
//
//  Created by PHAM HONG DUY on 6/19/23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Declaration
    @StateObject private var userManager = UserManager()
    
    // MARK: - Body
    var body: some View {
        if userManager.isFirstTimeUser { // check user đã tạo username trước đó rồi thì sẽ vô phần notes cá nhân, chưa sẽ ở mh tạo
            FirstTimeUserView(userManager: userManager)
        } else {
            NoteListView(noteViewModel: NoteViewModel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
