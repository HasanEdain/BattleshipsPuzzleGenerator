//
//  PuzzleView.swift
//  BattleshipsPuzzleCreator
//
//  Created by Hasan Edain on 9/29/24.
//

import SwiftUI

struct PuzzleView: View {
    @EnvironmentObject var puzzle: Puzzle
    var showPuzzle: Bool = true
    var showWater: Bool

    var body: some View {
        VStack (spacing: 0.0) {
            ForEach(0..<puzzle.height, id: \.self) { yIndex in
                HStack (spacing: 0.0) {
                    ForEach(0..<puzzle.width, id: \.self) { xIndex in
                        if showPuzzle {
                            TileView(tile: puzzle.tile(at: Location(x: xIndex, y: yIndex)), showWater: showWater)
                        } else {
                            TileView(tile: Tile.empty(), showWater: showWater)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let emptyPuzzle: Puzzle = Puzzle.emptyPuzzle(width: 10, height: 10)
    let tenTenOne: Puzzle = Ten_Ten.one

    VStack {
        PuzzleView(showWater: false)
            .environmentObject(emptyPuzzle)
        PuzzleView(showWater: true)
            .environmentObject(tenTenOne)
    }
}
