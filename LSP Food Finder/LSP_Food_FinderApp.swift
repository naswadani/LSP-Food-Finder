//
//  LSP_Food_FinderApp.swift
//  LSP Food Finder
//
//  Created by naswakhansa on 06/01/25.
//

import SwiftUI

@main
struct LSP_Food_FinderApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: AuthViewModel(repository: AuthRepository(authDataHandler: AuthDataHandler())))
        }
    }
}
