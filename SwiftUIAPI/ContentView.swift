//
//  ContentView.swift
//  SwiftUIAPI
//
//  Created by Юлия  on 08.09.2024.
//


import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = UsersViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                if vm.isRefreshing {
                    ProgressView()
                } else {
                    List {
                        ForEach(vm.users, id: \.id) { user in
                            UserView(user: user)
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Users")
            .onAppear(perform: vm.fetchUsers)
            .alert(isPresented: $vm.hasError,
                   error: vm.error) {
                Button(action: vm.fetchUsers) {
                    Text("Retry")
                }
            }
        }
    }
}

