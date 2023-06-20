//
//  UserManager.swift
//  Pham Hong Duy Notes
//
//  Created by PHAM HONG DUY on 6/19/23.
//

import Foundation
import FirebaseDatabase

class UserManager: ObservableObject {
    
    // MARK: - Declaration
    @Published var isFirstTimeUser: Bool = false // biến check lần đầu vào app của user, đc sử dụng trong ObservableObject. đối tượng ở view quan sát @observableObject thay đổi cập nhật tương ứng
    private let userUUIDKey = "userUUIDKey" // key userUUID
    private let dbFireBase = Database.database().reference() // db của firebase
    private let isFirstTimeUserKey = "isFirstTimeUser" // key check lần đầu tiên vào app
    
    // MARK: - Functions
    init() {
        checkUserPermission()
    }
            
    func checkUserPermission() {
        if let userUUID = UserDefaults.standard.value(forKey: self.userUUIDKey) as? String { // check xem co phải lần đầu tạo user không, nếu k tạo mới, nếu có cho vào view khác nhau
            let userUUIDRef = dbFireBase.child("user").child(userUUID)
            
            userUUIDRef.observeSingleEvent(of: .value) {[weak self] data, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error checkUserPermission \(error)")
                    return
                }
                
                if data.exists() { // check xem db realtime có còn user đó không
                    self.isFirstTimeUser = false // xét lại Published để update UI nơi gọi isFirstTimeUser
                }
            }
        }
            
        self.isFirstTimeUser = true
    }
    
    func confirmUserCreation(userName: String) {
        let userUUID = UUID().uuidString
                
        self.createUserInDatabase(userUUID: userUUID, userName: userName)
    }
    
    func createUserInDatabase(userUUID: String, userName: String) { // lưu vào db theo user UUID
        let userChildRef = dbFireBase.child("user").child(userUUID)
        
        let userData: [String: Any] = [
            "userName": userName,
            "userUUID": userUUID,
            "canRead": true,
            "canWrite": true
        ]
        
        // sau khi lưu thành công sẽ lưu biến lại, và chuyển trang
        userChildRef.setValue(userData) { [weak self] error, _ in
            guard let self = self else { return }
            if let error = error {
                print("Error creating user: \(error)")
            } else {
                UserDefaults.standard.setValue(userUUID, forKey: self.userUUIDKey)
                UserDefaults.standard.setValue(false, forKey: self.isFirstTimeUserKey)
                
                self.isFirstTimeUser = false
            }
        }
    }
    
    
}
