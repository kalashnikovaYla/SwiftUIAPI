//
//  UserView.swift
//  SwiftUIAPI
//
//  Created by Юлия  on 08.09.2024.
//

import SwiftUI

struct UserView: View {
    
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("**Name**: \(user.name)")
            Text("**Email**: \(user.email)")
            Divider()
            Text("**Company**: \(user.company.name)")

        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 4)
    }
}

