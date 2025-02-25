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
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
            switch card.isMatched {
            case .Matched: RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.green, lineWidth: card.isFaceUp ? 3 : 1)
            case .NotMatched: RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.7), lineWidth: card.isFaceUp ? 3 : 1)
            case .Selected: RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.orange.opacity(0.5), lineWidth: card.isFaceUp ? 3 : 1)
            }
                
            contents
            Color.black
                .opacity(card.isFaceUp ? 0 : 1)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .accessibilityIdentifier("CardElement_\(card.id)")
    }
    
    @ViewBuilder
    var contents: some View {
        let bodyColor = card.color.toSwiftUIColor()
        let numberOfContents: Int = card.numberOfContents.rawValue
        
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
}

typealias Card = AnimatedSetGameModel.Card
#Preview {
    CardView(card: AnimatedSetGameModel.Card(id: "dsfd", content: Card.Shape.Oval, numberOfContents: Card.NumberOfContents.One, color: Card.Color.Red, shading: Card.Shading.Solid))
}
