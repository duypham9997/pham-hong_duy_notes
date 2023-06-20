//
//  UserModal.swift
//  Pham Hong Duy Notes
//
//  Created by PHAM HONG DUY on 6/19/23.
//

import Foundation
import SwiftUI

struct UserModal: View { // modal hiển thị danh sách tất cả User
    
    // MARK: - Declaration
    @Binding var listUser: [User] // list All user
    @Binding var isShowingModal: Bool // check hiển thị modal hay không, liên kết giữa view cha và view con, quan sát sự thay đổi giữa view cha và view con
    
    // MARK: - Call back
    var userResponse: (_ user: User) -> Void // callback trả về data cho view xử lí
    
    // MARK: - Body
    var body: some View {
        VStack {
            List(listUser) { user in
                Button(action: { // callback trả về data user để xử lí
                    userResponse(user)
                    isShowingModal = false
                }) {
                    Text(user.userName)
                }
            }
        }
        .padding()
    }
}
