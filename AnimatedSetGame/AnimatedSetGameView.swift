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
            bottomBar
                .padding()
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
                    .onTapGesture {
                        viewModel.chooseCard(card)
                    }
                    .accessibilityIdentifier("CardElement")
            }
        )
        .frame(maxWidth: .infinity, maxHeight: 400)
    }
    
    var bottomBar: some View {
        HStack {
            Button {
                viewModel.addThreeMoreCardsToShowingCards()
            } label: {
                Text(
                    """
                    Add 3
                    More Cards!
                    """
                )
                    .setGameButtonize()
            }
            .accessibilityIdentifier("Add3MoreCardsButton")
            
            Button {
                viewModel.createGame()
            } label: {
                Text("Start New Game!")
                    .setGameButtonize()
            }
            .accessibilityIdentifier("StartNewGameButton")
        }
    }
}

#Preview {
    AnimatedSetGameView(viewModel: AnimatedSetGameViewModel())
}
