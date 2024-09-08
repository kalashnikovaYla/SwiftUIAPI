//
//  UsersViewModel.swift
//  SwiftUIAPI
//
//  Created by Юлия  on 08.09.2024.
//

import Foundation

final class UsersViewModel: ObservableObject {
    
    @Published var hasError = false
    @Published var error: UserError?
    
    @Published var users: [User] = []
    @Published private(set) var isRefreshing = false
    
    
    func fetchUsers() {
        hasError = false
        isRefreshing = true
        
        let usersUrlString = "https://jsonplaceholder.typicode.com/users"
        if let url = URL(string: usersUrlString) {
            
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                    DispatchQueue.main.async {
                        
                        ///defer в Swift — это специальное ключевое слово, которое позволяет отложить выполнение блока кода до тех пор, пока управление не выйдет из текущей области видимости (например, из функции или замыкания). Это полезно для выполнения завершающих действий, таких как очистка ресурсов, сброс состояний или, в данном случае, изменение состояния переменной.
                        ///независимо от того, как завершится выполнение блока кода внутри замыкания URLSession.shared.dataTask, self?.isRefreshing будет установлено в false в конце выполнения этого блока.
                        ///Таким образом, если произойдет ошибка, и код выполнит self?.hasError = true и self?.error = ..., то после этого, даже если произошла ошибка, isRefreshing выполнится и будет установлен в false. То же самое произойдет, если данные успешно получены и обработаны.
                        ///Использование defer здесь помогает избежать дублирования кода, поскольку вам не нужно повторять установку isRefreshing в false в нескольких местах. Цель состоит в том, чтобы гарантировать, что это действие произойдет в любом случае, когда управление покинет блок, что улучшает читаемость и надежность кода.
                        defer {
                            self?.isRefreshing = false
                        }
                        if let error = error {
                            self?.hasError = true
                            self?.error = UserError.custom(error: error)
                        } else {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            if let data = data,
                               let users = try? decoder.decode([User].self, from: data) {
                                self?.users = users
                            } else {
                                self?.hasError = true
                                self?.error = UserError.failedToDecode
                            }
                        }
                    }
                }.resume()
        }
    }
}

extension UsersViewModel {
    enum UserError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
