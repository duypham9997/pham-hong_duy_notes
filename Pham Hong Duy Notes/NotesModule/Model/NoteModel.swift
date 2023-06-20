//
//  Note.swift
//  Pham Hong Duy Notes
//
//  Created by PHAM HONG DUY on 6/19/23.
//

import Foundation

struct Note: Identifiable, Codable { // đại diện cho mô hình ghi chú
    let id: String
    let title: String
    let content: String
}
