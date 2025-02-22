//
//  AnimatedSetGameApp.swift
//  AnimatedSetGame
//
//  Created by 김도현 on 2/22/25.
//

import SwiftUI

@main
struct AnimatedSetGameApp: App {
    @StateObject var animatedSetGameViewModel = AnimatedSetGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            AnimatedSetGameView(viewModel: animatedSetGameViewModel)
        }
    }
}
