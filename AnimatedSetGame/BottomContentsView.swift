//
//  BottomContentsView.swift
//  AnimatedSetGame
//
//  Created by 김도현 on 2/25/25.
//

import SwiftUI

struct BottomContentsView: View {
    @ObservedObject var viewModel: AnimatedSetGameViewModel
    var body: some View {
        HStack(spacing: 20) {
            bottomDecks
            newGameButton
            discardedCardsDeck
        }
        .padding(.horizontal)
    }
    var newGameButton: some View {
        Button {
            withAnimation(.spring(duration: 0.8, bounce: 0.3)) {
                viewModel.createGame()
            }

        } label: {
            Image(systemName: "formfitting.gamecontroller.fill")
                .setGameButtonize(deckWidth: deckWidth, aspectRatio: aspectRatio)
        }
        .accessibilityIdentifier("StartNewGameButton")
    }
    
    var cardDeckNamespace: Namespace.ID
    @ViewBuilder
    var bottomDecks: some View {
        ZStack {
            ForEach(viewModel.deck, id: \.self.id) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: cardDeckNamespace)
            }
            Text("\(viewModel.deck.count)")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.white)
        }
        .frame(maxWidth: deckWidth, maxHeight: deckWidth / aspectRatio)
        .onTapGesture {
            withAnimation(.spring(duration: 0.5, bounce: 0.4)) {
                viewModel.addThreeMoreCardsToShowingCards()
            }
        }
        .accessibilityIdentifier("Add3MoreCardsButton")
    }
    
    var discardedCardsNamespace: Namespace.ID
    var discardedCardsDeck: some View {
        ZStack {
            ForEach(viewModel.disCardedCards) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: discardedCardsNamespace)
                    .transition(.identity)
            }
        }
        .frame(maxWidth: deckWidth, maxHeight: deckWidth / aspectRatio)
    }
    
    private let deckWidth: CGFloat = 60
    private let aspectRatio: CGFloat = 2/3
}

#Preview {
    @Namespace var discardedCardsNamespace
    @Namespace var cardDeckNamespace
    BottomContentsView(viewModel: AnimatedSetGameViewModel(), cardDeckNamespace: cardDeckNamespace, discardedCardsNamespace: discardedCardsNamespace)
}
