//
//  Location.swift
//  BattleshipsPuzzleCreator
//
//  Created by Hasan Edain on 9/29/24.
//

import Foundation

class Location: CustomDebugStringConvertible, Comparable, Identifiable, ObservableObject, Hashable, Codable {
    @Published var x: Int
    @Published var y: Int
    @Published var id: UUID

    init(x: Int, y: Int, id: UUID = UUID()) {
        self.x = x
        self.y = y
        self.id = id
    }

    //MARK: - Codable
    enum CodingKeys: CodingKey {
        case id
        case x
        case y
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        x = try container.decode(Int.self, forKey: .x)
        y = try container.decode(Int.self, forKey: .y)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
    }

    //MARK: - Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        if lhs.x != rhs.x {
            return false
        }

        if lhs.y != rhs.y {
            return false
        }

        return true
    }

    static func < (lhs: Location, rhs: Location) -> Bool {
        if lhs.x < rhs.x {
            return true
        }
        if lhs.y < rhs.y {
            return true
        }

        return false
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(id)
    }

    func isInvalidLocation() -> Bool {
        if x < 0 {
            return true
        } else if y < 0 {
            return true
        }

        return false
    }

    var debugDescription: String {
        return String("(x: \(x) y:\(y))")
    }
}
