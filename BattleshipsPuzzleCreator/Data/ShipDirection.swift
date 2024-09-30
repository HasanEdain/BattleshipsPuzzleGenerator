//
//  ShipDirection.swift
//  BattleshipsPuzzleCreator
//
//  Created by Hasan Edain on 9/29/24.
//

import Foundation

enum ShipDirection: Codable {
    case vertical
    case horizontal

    static var random: ShipDirection {
        let rnd = Int.random(in: 0...1)
        if rnd == 0 {
            return horizontal
        } else {
            return vertical
        }
    }
}
