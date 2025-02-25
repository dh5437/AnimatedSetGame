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
                .padding(0)
            cardMatched
            cards
            
            Spacer()
            BottomContentsView(viewModel: viewModel, cardDeckNamespace: cardDeckNamespace, discardedCardsNamespace: discardedCardsNamespace)
        }
        .padding(.horizontal)
        .onAppear {
            viewModel.createGame()
        }
    }
    
    var cardMatched: some View {
        HStack(alignment: .center ,spacing: 10) {
            VStack(alignment: .center) {
                Text("Score")
                Text("\(viewModel.score)")
            }
            .font(.system(size: 16, weight: .bold))
            .foregroundStyle(.white)
            .padding()
            .background(.gray)
            .frame(height: 60)
            .clipShape(
                Capsule()
            )
            
            Group {
                switch viewModel.areCardsMatched {
                case .Selected:
                    Text("Selecting cards...")
                        .textify(foregroundColor: .white, backgroundColor: .black)
                case .NotMatched:
                    Text("Cards are not set!")
                        .textify(foregroundColor: .red, backgroundColor: Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)))
                case .Matched:
                    Text("Cards are set!")
                        .textify(foregroundColor: .green, backgroundColor: Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)))
                }
            }
            .frame(height: 60)
        }
        .frame(maxWidth: .infinity, maxHeight: 60)
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
    
    var cards: some View {
        AspectVGrid(items: viewModel.showingCards, contentRatio: 2/3, content: { card in
            CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .matchedGeometryEffect(id: card.id, in: discardedCardsNamespace)
                    .matchedGeometryEffect(id: card.id, in: cardDeckNamespace)
                    .transition(.identity)
                    .onTapGesture {
                        withAnimation(.spring(duration: 0.5, bounce: 0.4)) {
                            viewModel.chooseCard(card)
                        }
                    }
                    .accessibilityIdentifier("CardElement_\(card.id)")
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
