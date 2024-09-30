//
//  RowCluesView.swift
//  BattleshipsPuzzleCreator
//
//  Created by Hasan Edain on 9/29/24.
//

import SwiftUI

struct ColumnCluesView: View {
    @EnvironmentObject var puzzle: Puzzle

    var body: some View {
        HStack (spacing: 0.0) {
            ForEach(puzzle.columnCounts.indices, id: \.self) { index in
                Text("\(puzzle.columnCounts[index])")
                    .frame(width: 24.0, height: 24.0)
            }
        }
    }
}

#Preview {
    let tenTenOne = Ten_Ten.one

    ColumnCluesView()
        .environmentObject(tenTenOne)
}
