//
//  StrippedPattern.swift
//  AnimatedSetGame
//
//  Created by 김도현 on 2/22/25.
//
import SwiftUI

struct StrippedPattern: Shape {
    // 줄무늬에 그려지는 선의 개수
    let numberOfLine: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for i in 0..<numberOfLine {
            let xPos = rect.minX + rect.width * (CGFloat(i) / CGFloat(numberOfLine - 1))
            path.move(to: CGPoint(x: xPos, y: rect.minY))
            path.addLine(to: CGPoint(x: xPos, y: rect.maxY))
        }
        
        return path
    }
}

