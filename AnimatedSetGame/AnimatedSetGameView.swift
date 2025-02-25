//
//  AnimatedSetGameView.swift
//  AnimatedSetGame
//
//  Created by 김도현 on 2/22/25.
//

import SwiftUI

struct AnimatedSetGameView: View {
    
    @ObservedObject var viewModel: AnimatedSetGameViewModel
    
    var body: some View {
        VStack {
            Text("Animated Set Game")
                .font(.largeTitle)
                .fontWeight(.bold)
            cards
            
            Spacer()
            BottomContentsView(viewModel: viewModel, cardDeckNamespace: cardDeckNamespace, discardedCardsNamespace: discardedCardsNamespace)
        }
        .padding()
        .onAppear {
            viewModel.createGame()
        }
    }
    
    var cards: some View {
        AspectVGrid(items: viewModel.showingCards, contentRatio: 2/3, content: { card in
            CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .matchedGeometryEffect(id: card.id, in: discardedCardsNamespace)
                    .matchedGeometryEffect(id: card.id, in: cardDeckNamespace)
                    .transition(.identity)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            viewModel.chooseCard(card)
                        }
                    }
                    .accessibilityIdentifier("CardElement")
            }
        )
        .frame(maxWidth: .infinity, maxHeight: 400)
    }
    @Namespace private var discardedCardsNamespace
    @Namespace private var cardDeckNamespace
}

#Preview {
    AnimatedSetGameView(viewModel: AnimatedSetGameViewModel())
}
