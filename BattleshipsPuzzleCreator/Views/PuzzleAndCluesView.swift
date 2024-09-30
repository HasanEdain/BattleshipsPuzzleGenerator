//
//  PuzzleAndCluesView.swift
//  BattleshipsPuzzleCreator
//
//  Created by Hasan Edain on 9/29/24.
//

import SwiftUI

struct PuzzleAndCluesView: View {
    @EnvironmentObject var puzzle: Puzzle
    let showShips: Bool
    var showWater: Bool

    var body: some View {
        HStack (alignment: .top ,spacing: 0.0){
            VStack (spacing: 0.0){
                PuzzleView(showPuzzle: showShips, showWater: showWater)
                ColumnCluesView()
            }
            RowCluesView()
        }
    }
}

#Preview {
    let tenTenOne = Ten_Ten.one
    VStack {
        PuzzleAndCluesView(showShips: false, showWater: true)
            .padding()
            .environmentObject(tenTenOne)
        PuzzleAndCluesView(showShips: true, showWater: true)
            .padding()
            .environmentObject(tenTenOne)
    }

}
