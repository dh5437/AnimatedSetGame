//
//  Shading.swift
//  AnimatedSetGame
//
//  Created by 김도현 on 2/22/25.
//

import SwiftUI

struct Shading: ViewModifier {
    var shading: AnimatedSetGameModel.Card.Shading
    var color: AnimatedSetGameModel.Card.Color
    
    func body(content: Content) -> some View {
        let bodyColor = color.toSwiftUIColor()
        switch shading {
        case .Solid:
            content
                .foregroundStyle(bodyColor)
            
        case .Stripped:
            StrippedPattern(numberOfLine: 15)
                .stroke(lineWidth: 1)
                .fill(bodyColor)
                .mask(content)
            
        case .Open:
            content
                .foregroundStyle(Color.clear)
        }
    }
}

extension View {
    func shading(_ shading: AnimatedSetGameModel.Card.Shading, color: AnimatedSetGameModel.Card.Color) -> some View {
        modifier(Shading(shading: shading, color: color))
    }
}
