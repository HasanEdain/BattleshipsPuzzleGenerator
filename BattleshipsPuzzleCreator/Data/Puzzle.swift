    //
    //  Puzzle.swift
    //  BattleshipsPuzzleCreator
    //
    //  Created by Hasan Edain on 9/29/24.
    //

import Foundation

class Puzzle:ObservableObject, CustomDebugStringConvertible, Codable {
    @Published var tiles: [Tile]
    @Published var width: Int
    @Published var height: Int

        //MARK: - Init
    init(tiles: [Tile], width: Int, height: Int) {
        self.tiles = tiles
        self.width = width
        self.height = height
    }

        //MARK: - Codable
    enum CodingKeys: CodingKey {
        case tiles
        case width
        case height
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tiles = try container.decode([Tile].self, forKey: .tiles)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(tiles, forKey: .tiles)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
    }

        //MARK: - CustomDebugStringConvertible
    var debugDescription: String {
        var result = ""
        result.append("width:\(width)\n")
        result.append("height:\(height)\n")
        result.append("[\n")
        for yIndex in 0..<height {
            for xIndex in 0..<width {
                result.append("\(tile(at: Location(x: xIndex, y: yIndex)))")
                if xIndex < width - 1 {
                    result.append(", ")
                }
            }
            result.append("\n")
        }

        result.append("]\n")

        return result
    }

        //MARK: - Counts
    func columnCount(column: Int) -> Int {
        var count = 0
        for index in 0..<width {
            let location = Location(x: column, y: index)
            if hasShip(location: location) {
                count = count + 1
            }
        }

        return count
    }

    var columnCounts: [Int] {
        var counts: [Int] = []
        for yIndex in 0..<height {
            let columnCount = columnCount(column: yIndex)
            counts.append(columnCount)
        }

        return counts
    }

    func rowCount(row: Int) -> Int {
        var count = 0
        for index in 0..<height {
            let location = Location(x: index, y: row)
            if hasShip(location: location) {
                count = count + 1
            }
        }
        return count
    }

    var rowCounts: [Int] {
        var counts: [Int] = []

        for xIndex in 0..<width {
            let rowCount = rowCount(row: xIndex)
            counts.append(rowCount)
        }

        return counts
    }


        //MARK: - Access
    func isValidLocation(location: Location) -> Bool {
        var result = true

        if location.x < 0 {
            result = false
        }
        if location.y < 0 {
            result = false
        }
        if location.x >= width {
            return false
        }
        if location.y >= height {
            return false
        }

        return result
    }

    func index(location: Location) -> Int {
        let index = width * location.y + location.x

        if isValidLocation(location: location) {
            return index
        } else {
            return 0
        }
    }

    func tile(at location: Location) -> Tile {
        if isValidLocation(location: location) {
            let index = index(location: location)

            let tile = tiles[index]

            return tile
        } else {
            return Tile.empty()
        }
    }

    func hasShip(location: Location) -> Bool {
        let tile = tile(at: location)

        return tile.isShip()
    }


        //MARK: - Mutate
    func update(tileType: TileType, location: Location) {
        if isValidLocation(location: location) {
            let index = index(location: location)
            tiles[index].type = tileType
        } else {
            print("Tried to update invalid location: \(location)")
        }
    }

    func clear() {
        tiles = Puzzle.emptyArray(width: width, height: height)
    }

        //MARK: Create
    static func emptyPuzzle(width: Int, height: Int) -> Puzzle {
        let tempTiles = emptyArray(width: width, height: height)

        return Puzzle(tiles: tempTiles, width: width, height: height)
    }

    static func emptyArray(width: Int, height: Int) -> [Tile] {
        var tempTiles:[Tile] = []
        for _ in 0..<height {
            for _ in 0..<width {
                tempTiles.append(Tile.empty())
            }
        }

        return tempTiles
    }

        //MARK: - Place
    func place(shipSet: ShipSet) {
        let ships = shipSet.reversed
        ships.forEach { ship in
            place(ship: ship)
        }
    }

    func place(ship: ShipLength) {
        let direction = ShipDirection.random
        place(ship: ship, direction: direction)
    }

    func place(ship: ShipLength, direction: ShipDirection) {
        var emptyLocations:[Location] = emptyLocations()
        var placed: Bool = false

        while placed == false && emptyLocations.count > 0 {
            let randomIndex = Int.random(in: 0..<emptyLocations.count)
            let randomLocation = emptyLocations[randomIndex]
            if canPlace(ship: ship, direction: direction, location: randomLocation) {
                let shipLocations: [Location] = ship.shipLocations(location: randomLocation, dirction: direction)
                if shipLocations.count == 1 {
                    update(tileType: TileType.oneLongShip, location: shipLocations[0])
                } else {
                    for index in 0..<shipLocations.count {
                        let location: Location = shipLocations[index]
                        if index == 0 {
                            if direction == .horizontal {
                                update(tileType: TileType.shipEndEast, location: location)
                            } else {
                                update(tileType: TileType.shipEndSouth, location: location)
                            }
                        } else if index == shipLocations.count - 1 {
                            if direction == .horizontal {
                                update(tileType: TileType.shipEndWest, location: location)
                            } else {
                                update(tileType: TileType.shipEndNorth, location: location)
                            }
                        } else {
                            update(tileType: TileType.shipMiddle, location: location)
                        }
                    }
                }
                placed = true
                surround(ship: ship, direction: direction, location: randomLocation)
            }

            emptyLocations.remove(at: randomIndex)
        }
    }


func canPlace(ship: ShipLength, direction: ShipDirection, location: Location) -> Bool {
    if isValidLocation(location: location) == false {
        return false
    }

    let shipLocations = ship.shipLocations(location: location, dirction: direction)

    var allShipLocationsInBoard = true
    shipLocations.forEach { location in
        if isValidLocation(location: location) == false {
            allShipLocationsInBoard = false
        }
    }
    if allShipLocationsInBoard == false {
        return false
    }

    let shipIndex = shipLocations.firstIndex { location in
        tile(at: location).type != .empty
    }

    if shipIndex != nil {
        return false
    }

    let waterLocations = ship.waterLocations(location: location, direction: direction)
    let waterIndex = waterLocations.first { location in
        let tile = tile(at: location)
        return ((tile.type != .empty) && (tile.type != .water))
    }

    if waterIndex != nil {
        return false
    }

    return true
}

func surround(ship: ShipLength, direction: ShipDirection, location: Location) {
    let surroundTiles = ship.waterLocations(location: location, direction: direction)

    surroundTiles.forEach { location in
        if isValidLocation(location: location) {
            update(tileType: .water, location: location)
        }
    }
}

func emptyLocations() -> [Location] {
    var tempLocations: [Location] = []
    for yIndex in 0..<height {
        for xIndex in 0..<width {
            let location = Location(x: xIndex, y: yIndex)
            let value = tile(at: location)
            if value.type == .empty {
                tempLocations.append(location)
            }
        }
    }

    return tempLocations
}
}
