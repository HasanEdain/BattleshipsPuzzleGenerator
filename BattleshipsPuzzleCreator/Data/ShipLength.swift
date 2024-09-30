//
//  ShipLength.swift
//  BattleshipsPuzzleCreator
//
//  Created by Hasan Edain on 9/29/24.
//

import Foundation

enum ShipLength: Codable {
    case one
    case two
    case three
    case four
    case five
    case six

    var area: Int {
        switch self {
            case .one:
                return 9
            case .two:
                return 12
            case .three:
                return 14
            case .four:
                return 16
            case .five:
                return 18
            case .six:
                return 20
        }
    }

    var value: Int {
        switch self {
            case .one:
                return 1
            case .two:
                return 2
            case .three:
                return 3
            case .four:
                return 4
            case .five:
                return 5
            case .six:
                return 6
        }
    }

    init(value: Int) {
        if value == 1 {
            self = .one
        } else if value == 2 {
            self = .two
        } else if value == 3 {
            self = .three
        } else if value == 4 {
            self = .four
        } else if value == 5 {
            self = .five
        } else if value == 6 {
            self = .six
        } else {
            self = .one
        }
    }

    func shipLocations(location: Location, dirction: ShipDirection) -> [Location] {
        if dirction == .horizontal {
            return shipLocationsHorizontal(location: location)
        } else {
            return shipLocationsVertical(location: location)
        }
    }

    func waterLocations(location: Location, direction: ShipDirection) -> [Location] {
        if direction == .horizontal {
            return waterLocationsHorizontal(location: location)
        } else {
            return waterLocationsVertical(location: location)
        }
    }

    private func shipLocationsHorizontal(location: Location) -> [Location] {
        var tempLocations = [location]
        for index in 1..<value {
            tempLocations.append(Location(x: location.x + index, y: location.y))
        }

        return tempLocations
    }

    private func shipLocationsVertical(location: Location) -> [Location] {
        var tempLocations = [location]
        for index in 1..<value {
            tempLocations.append(Location(x: location.x, y: location.y + index))
        }

        return tempLocations
    }

    private func waterLocationsHorizontal(location: Location) -> [Location] {
        var tempLocations: [Location] = []

        tempLocations.append(Location(x: location.x - 1, y: location.y))
        tempLocations.append(Location(x: location.x + value, y: location.y))

        let start = location.x - 1
        let end = location.x + value

        for index in start...end {
            tempLocations.append(Location(x: index, y: location.y - 1))
            tempLocations.append(Location(x: index, y: location.y + 1))
        }

        return tempLocations
    }

    private func waterLocationsVertical(location: Location) -> [Location] {
        var tempLocations: [Location] = []

        tempLocations.append(Location(x: location.x, y: location.y - 1))
        tempLocations.append(Location(x: location.x, y: location.y + value))

        let start = location.y - 1
        let end = location.y + value

        for index in start...end {
            tempLocations.append(Location(x: location.x - 1, y: index))
            tempLocations.append(Location(x: location.x + 1, y: index))
        }

        return tempLocations
    }
}
