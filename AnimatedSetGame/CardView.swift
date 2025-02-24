//
//  CardView.swift
//  AnimatedSetGame
//
//  Created by 김도현 on 2/22/25.
//

import SwiftUI

struct CardView: View {
    typealias Card = AnimatedSetGameModel.Card
    var card: Card
    
    var body: some View {
        let bodyColor = card.color.toSwiftUIColor()
        let numberOfContents: Int = card.numberOfContents.rawValue
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(card.isSelected ? Color.orange.opacity(0.5) : Color.gray.opacity(0.7), lineWidth: 3)
            
            VStack {
                ForEach(0..<numberOfContents, id: \.self) { index in
                    switch card.content {
                    case .Diamond:
                        Diamond()
                            .shading(card.shading, color: card.color)
                            .overlay(Diamond().stroke(bodyColor, lineWidth: 2))
                            .frame(maxWidth: 60, maxHeight: 30)
                    case .Squiggle:
                        Squiggle()
                            .shading(card.shading, color: card.color)
                            .overlay(Squiggle().stroke(bodyColor, lineWidth: 2))
                            .frame(maxWidth: 60, maxHeight: 30)
                    case .Oval:
                        Capsule()
                            .shading(card.shading, color: card.color)
                            .overlay(Capsule().stroke(bodyColor, lineWidth: 2))
                            .frame(maxWidth: 60, maxHeight: 30)
                    }
                }
            }
            .padding()
        }
        .accessibilityIdentifier("CardElement_\(card.id)")
    }
}

typealias Card = AnimatedSetGameModel.Card
#Preview {
    CardView(card: AnimatedSetGameModel.Card(id: "dsfd", content: Card.Shape.Oval, numberOfContents: Card.NumberOfContents.One, color: Card.Color.Red, shading: Card.Shading.Solid))
}
