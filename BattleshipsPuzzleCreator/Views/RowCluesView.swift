//
//  ColunCluesView.swift
//  BattleshipsPuzzleCreator
//
//  Created by Hasan Edain on 9/29/24.
//

import SwiftUI

struct RowCluesView: View {
    @EnvironmentObject var puzzle: Puzzle

    var body: some View {
        VStack (spacing: 0.0){
            ForEach(puzzle.rowCounts.indices, id: \.self) { index in
                Text("\(puzzle.rowCounts[index])")
                    .frame(width: 24.0, height: 24.0)
            }
        }
    }
}

#Preview {
    let tenTenOne = Ten_Ten.one

    RowCluesView()
        .environmentObject(tenTenOne)
}
