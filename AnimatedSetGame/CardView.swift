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
        let bodyColor = card.color.resolve()
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 3)
            
            VStack {
                ForEach(0..<card.numberOfContents.rawValue) { index in
                    switch card.content {
                    case .Diamond:
                        Diamond()
                            .shading(card.shading, color: card.color)
                            .overlay(Diamond().stroke(Color(bodyColor), lineWidth: 2))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                    case .Squiggle:
                        Squiggle()
                            .shading(card.shading, color: card.color)
                            .overlay(Squiggle().stroke(Color(bodyColor), lineWidth: 2))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                    case .Oval:
                        Capsule()
                            .shading(card.shading, color: card.color)
                            .overlay(Capsule().stroke(Color(bodyColor), lineWidth: 2))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                    }
                }
            }
            .padding()
        }
    }
}

typealias Card = AnimatedSetGameModel.Card
#Preview {
    CardView(card: AnimatedSetGameModel.Card(id: "dsfd", content: Card.Shape.Oval, numberOfContents: Card.NumberOfContents.One, color: Card.Color.Red, shading: Card.Shading.Solid))
}
