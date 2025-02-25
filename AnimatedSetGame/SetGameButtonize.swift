//
//  SetGameButtonize.swift
//  AnimatedSetGame
//
//  Created by 김도현 on 2/24/25.
//

import SwiftUI

struct SetGameButtonize: ViewModifier {
    let deckWidth: CGFloat
    let aspectRatio: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .bold, design: .default))
            .foregroundColor(.white)
            .padding(16)
            .frame(width: deckWidth, height: deckWidth / aspectRatio)
            .background(Color.blue)
            .cornerRadius(20)
    }
}

extension View {
    func setGameButtonize(deckWidth: CGFloat, aspectRatio: CGFloat) -> some View {
        modifier(SetGameButtonize(deckWidth: deckWidth, aspectRatio: aspectRatio))
    }
}

#Preview {
    Button {
        print("Hello world!")
    } label: {
        Text("Hello world!")
            .setGameButtonize(deckWidth: 200, aspectRatio: 2/3)
    }

}
