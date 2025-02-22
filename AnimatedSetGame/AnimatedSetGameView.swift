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
        ScrollView {
            VStack {
                Text("Animated Set Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                cards
                
                Spacer()
            }
            .padding()
            .onAppear {
                viewModel.createDeck()
            }
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
            ForEach(viewModel.deck, id: \.self.id) { card in
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
}

#Preview {
    AnimatedSetGameView(viewModel: AnimatedSetGameViewModel())
}
