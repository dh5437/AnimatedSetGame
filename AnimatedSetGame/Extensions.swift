//
//  Extensions.swift
//  AnimatedSetGame
//
//  Created by 김도현 on 2/25/25.
//

import SwiftUI

extension AnimatedSetGameModel.Card.Color {
    func toSwiftUIColor() -> Color {
        switch self {
        case .Red: return Color.red
        case .Green: return Color.green
        case .Blue: return Color.blue
        }
    }
}
