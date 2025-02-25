//
//  Textify.swift
//  AnimatedSetGame
//
//  Created by 김도현 on 2/25/25.
//

import SwiftUI

struct Textify: ViewModifier {
    var foregroundColor: Color
    var backgroundColor: Color
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(foregroundColor)
            .padding(.bottom, 5)
            .padding(.horizontal)
            .frame(height: 60)
            .background(backgroundColor)
            .cornerRadius(10)
            .transition(.scale.animation(.spring(duration: 0.8, bounce: 0.5)))
    }
}

extension View {
    func textify(foregroundColor: Color, backgroundColor: Color) -> some View {
        self.modifier(Textify(foregroundColor: foregroundColor, backgroundColor: backgroundColor))
    }
}

#Preview {
    Text("Hello, World!")
        .textify(foregroundColor: .white, backgroundColor: .black)
}
