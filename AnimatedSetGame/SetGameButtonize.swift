//
//  SetGameButtonize.swift
//  AnimatedSetGame
//
//  Created by 김도현 on 2/24/25.
//

import SwiftUI

struct SetGameButtonize: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18, weight: .bold, design: .default))
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(20)
            .frame(minWidth: 100, maxWidth: 200, minHeight: 40, maxHeight: 80)
    }
}

extension View {
    func setGameButtonize() -> some View {
        modifier(SetGameButtonize())
    }
}

#Preview {
    Button {
        print("Hello world!")
    } label: {
        Text("Hello world!")
            .setGameButtonize()
    }

}
