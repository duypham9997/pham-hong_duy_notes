//
//  UserModel.swift
//  Pham Hong Duy Notes
//
//  Created by PHAM HONG DUY on 6/19/23.
//

import Foundation

struct User : Identifiable, Codable {
    var id = UUID() // Id địn danh User
    let userUUID: String
    let userName: String
}
