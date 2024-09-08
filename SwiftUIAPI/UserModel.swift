//
//  UserModel.swift
//  SwiftUIAPI
//
//  Created by Юлия  on 08.09.2024.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let name: String
    let company: Company
}

struct Company: Codable {
    let name: String
}
