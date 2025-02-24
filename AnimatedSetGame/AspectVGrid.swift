//
//  AspectVGrid.swift
//  AnimatedSetGame
//
//  Created by 김도현 on 2/24/25.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, Content: View>: View {
    let items: [Item]
    var contentRatio: CGFloat = 1
    let content: (Item) -> Content
    
    init(items: [Item], contentRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self.contentRatio = contentRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                contentRatio: contentRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 10)]) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(contentRatio, contentMode: .fit)
                }
            }
        }
    }
    
    private func gridItemWidthThatFits(count: Int, size: CGSize, contentRatio: CGFloat) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        
        repeat {
            let width = size.width / columnCount
            let height = width / contentRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width/count, size.height * contentRatio).rounded(.down)
    }
}
