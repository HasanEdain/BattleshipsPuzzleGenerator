//
//  TileType.swift
//  BattleshipsPuzzleCreator
//
//  Created by Hasan Edain on 9/29/24.
//

import SwiftUI

enum TileType: Codable, CustomDebugStringConvertible {
    case empty
    case water
    case shipEndNorth
    case shipEndSouth
    case shipEndEast
    case shipEndWest
    case shipMiddle
    case oneLongShip
    case genericShip

    var debugDescription: String  {
        switch self {
            case.empty:
                return "-"
            case .water:
                return "~"
            case .shipEndNorth:
                return "N"
            case .shipEndSouth:
                return "S"
            case .shipEndEast:
                return "E"
            case .shipEndWest:
                return "W"
            case .shipMiddle:
                return "M"
            case .oneLongShip:
                return "O"
            case .genericShip:
                return "G"
        }
    }

    init(typeString: String) {
        if typeString == "~" {
            self = TileType.water
        } else if typeString == "-" {
            self = TileType.empty
        } else if typeString == "N" {
            self = TileType.shipEndNorth
        } else if typeString == "S" {
            self = TileType.shipEndSouth
        } else if typeString == "E" {
            self = TileType.shipEndEast
        } else if typeString == "W" {
            self = TileType.shipEndWest
        } else if typeString == "M" {
            self = TileType.shipMiddle
        } else if typeString == "O" {
            self = TileType.oneLongShip
        } else if typeString == "G" {
            self = TileType.genericShip
        } else {
            self = TileType.empty
        }
    }

    var image: Image {
        switch self {
            case .empty:
                return Image("Empty")
            case .water:
                return Image("Water")
            case .shipEndNorth:
                return Image("ShipEndNorth")
            case .shipEndSouth:
                return Image("ShipEndSouth")
            case .shipEndEast:
                return Image("ShipEndEast")
            case .shipEndWest:
                return Image("ShipEndWest")
            case .shipMiddle:
                return Image("MidShip")
            case .oneLongShip:
                return Image("OneTileShip")
            case .genericShip:
                return Image("GenericShip")
        }
    }

    var isShip: Bool {
        switch self {
            case .empty:
                return false
            case .water:
                return false
            case .shipEndNorth:
                return true
            case .shipEndSouth:
                return true
            case .shipEndEast:
                return true
            case .shipEndWest:
                return true
            case .shipMiddle:
                return true
            case .oneLongShip:
                return true
            case .genericShip:
                return true
        }
    }
}
