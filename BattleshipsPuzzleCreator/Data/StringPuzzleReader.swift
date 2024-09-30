//
//  StringPuzzleReader.swift
//  BattleshipsPuzzleCreator
//
//  Created by Hasan Edain on 9/29/24.
//

import Foundation

struct StringPuzzleReader {

    static func puzzle(puzzleString: String) -> Puzzle {
        let lines = puzzleString.components(separatedBy: "\n")
        let width = numberFrom(line: lines[0])
        let height = numberFrom(line: lines[1])
        let contentLines = lines[3..<lines.count]
        var tiles = [Tile]()

        contentLines.forEach { contentString in
            let lineTiles = lineArray(lineString: contentString)
            lineTiles.forEach { tile in
                tiles.append(tile)
            }
        }

        let puzzle = Puzzle(tiles: tiles, width: width, height: height)

        return puzzle
    }

    static func lineArray(lineString: String) -> [Tile] {
        var tempTiles = [Tile]()
        let lineArray = lineString.components(separatedBy: ",")

        lineArray.forEach { tileString in
            let trimmed = tileString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            let tile = Tile(type: TileType(typeString: trimmed))
            tempTiles.append(tile)
        }

        return tempTiles
    }

    static func numberFrom(line: String) -> Int {
        let elements = line.components(separatedBy: ":")
        let valueString = elements[1]
        let trimmed = valueString.trimmingCharacters(in: .whitespacesAndNewlines)
        let number = Int(trimmed) ?? 0

        return number
    }
}
