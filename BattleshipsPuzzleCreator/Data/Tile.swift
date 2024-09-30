//
//  Tile.swift
//  BattleshipsPuzzleCreator
//
//  Created by Hasan Edain on 9/29/24.
//

import Foundation

class Tile: ObservableObject, Codable {
    @Published var type: TileType

    init(type: TileType) {
        self.type = type
    }

    static func empty() -> Tile {
        return Tile.init(type: .empty)
    }

    static func middle() -> Tile {
        return Tile.init(type: .shipMiddle)
    }

    func isShip() -> Bool {
        return type.isShip
    }

    //MARK: - Codable
    enum CodingKeys: CodingKey {
        case type
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(TileType.self, forKey: .type)

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
    }

}
