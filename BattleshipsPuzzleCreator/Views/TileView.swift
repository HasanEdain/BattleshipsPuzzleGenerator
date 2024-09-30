//
//  TileView.swift
//  BattleshipsPuzzleCreator
//
//  Created by Hasan Edain on 9/29/24.
//

import SwiftUI

struct TileView: View {
    var tile: Tile
    var showWater: Bool

    var body: some View {
        if tile.type == .water && showWater == false {
            Image("Empty")
                .resizable()
                .frame(width: 24.0,height: 24.0)
                .border(.black)
        } else {
            tile.type.image
                .resizable()
                .frame(width: 24.0,height: 24.0)
                .border(.black)
        }
    }
}

#Preview {

    VStack {
        TileView(tile: Tile(type: .empty), showWater: false)
        TileView(tile: Tile(type: .genericShip), showWater: false)
        TileView(tile: Tile(type: .oneLongShip), showWater: false)
        TileView(tile: Tile(type: .shipEndEast), showWater: false)
        TileView(tile: Tile(type: .shipEndWest), showWater: false)
        TileView(tile: Tile(type: .shipEndNorth), showWater: false)
        TileView(tile: Tile(type: .shipEndSouth), showWater: false)
        TileView(tile: Tile(type: .shipMiddle), showWater: false)
        TileView(tile: Tile(type: .water), showWater: true)
        TileView(tile: Tile(type: .water), showWater: false)
    }

}
