//
//  FirstTimeUserView.swift
//  Pham Hong Duy Notes
//
//  Created by PHAM HONG DUY on 6/19/23.
//

import SwiftUI

struct FirstTimeUserView: View {
    
    // MARK: - Declaration
    @ObservedObject var userManager: UserManager // ObservableObject của các đối tượng quản lý user, check user
    @State private var userName: String = ""
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("Welcome to The Pham Hong Duy notes App")
                .font(.title)
                .padding()
            
            TextField("Enter UserName", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Confirm") {
                if !userName.isEmpty { // kiểm tra nếu user đã nhập tên thì mới tạo
                    userManager.confirmUserCreation(userName: userName)
                }
            }
            .padding()
            .background(Color.yellow)
            .cornerRadius(8)
        }
        .padding()
    }
}

struct FirstTimeUserView_Previews: PreviewProvider {
    
    @ObservedObject private var userManager = UserManager()
    
    static var previews: some View {
        let userManager = UserManager()
        FirstTimeUserView(userManager: userManager)
    }
}
