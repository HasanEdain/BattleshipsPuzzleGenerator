//
//  ShipSet.swift
//  BattleshipsPuzzleCreator
//
//  Created by Hasan Edain on 9/29/24.
//

import Foundation

class ShipSet: ObservableObject, Codable, Hashable {
    @Published var lengths:[ShipLength] = []

    init(lengths: [ShipLength] = []) {
        self.lengths = lengths
    }

    //MARK: - Codable
    enum CodingKeys: CodingKey {
        case lengths
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lengths = try container.decode([ShipLength].self, forKey: .lengths)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lengths, forKey: .lengths)
    }

    //MARK: - Equatable
    static func == (lhs: ShipSet, rhs: ShipSet) -> Bool {
        if lhs.lengths.count != rhs.lengths.count {
            return false
        }

        var result = true

        for index in 0..<lhs.lengths.count {
            if lhs.lengths[index] != rhs.lengths[index] {
                result = false
            }
        }

        return result
    }

    //MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(lengths)
    }

    var reversed: [ShipLength] {
        return self.lengths.reversed()
    }

    static func setFor(number: Int) -> ShipSet {
        if number == 3 {
            return threeShips
        } else if number == 6 {
            return sixShips
        } else if number == 10 {
            return tenShips
        } else if number == 15 {
            return fifteenShips
        } else {
            return oneShip
        }
    }

    static var oneShip: ShipSet { //Min 1 x 1
        ShipSet(lengths: [ShipLength(value: 1)])
    }

    static var threeShips: ShipSet { //Min 5x5
        ShipSet(lengths: [ShipLength(value: 1),ShipLength(value: 1),ShipLength(value: 2)])
    }

    static var sixShips: ShipSet { //Min 6x6
        ShipSet(lengths: [ShipLength(value: 1),
                          ShipLength(value: 1),
                          ShipLength(value: 1),
                          ShipLength(value: 2),
                          ShipLength(value: 2),
                          ShipLength(value: 3)
                         ])
    }

    static var tenShips: ShipSet { //Min 9x9
        ShipSet(lengths: [
            ShipLength(value: 1),
            ShipLength(value: 1),
            ShipLength(value: 1),
            ShipLength(value: 1),
            ShipLength(value: 2),
            ShipLength(value: 2),
            ShipLength(value: 2),
            ShipLength(value: 3),
            ShipLength(value: 3),
            ShipLength(value: 4)
        ])
    }

    static var fifteenShips: ShipSet { //Min 13x13
        ShipSet(lengths: [
            ShipLength(value: 1),
            ShipLength(value: 1),
            ShipLength(value: 1),
            ShipLength(value: 1),
            ShipLength(value: 1),
            ShipLength(value: 2),
            ShipLength(value: 2),
            ShipLength(value: 2),
            ShipLength(value: 2),
            ShipLength(value: 3),
            ShipLength(value: 3),
            ShipLength(value: 3),
            ShipLength(value: 4),
            ShipLength(value: 4),
            ShipLength(value: 5)
        ])
    }
}
