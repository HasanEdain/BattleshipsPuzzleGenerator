//
//  Ten_Ten.swift
//  BattleshipsPuzzleCreator
//
//  Created by Hasan Edain on 9/29/24.
//

import Foundation

struct Ten_Ten {
    static var one: Puzzle {
        let string = """
        width : 10
        height : 10
        [
            -, E, M, M, W, -, -, -, -, -
             -, -, -, -, -, -, -, -, E, W
             -, E, W, -, -, -, O, -, -, -
             -, -, -, -, -, -, -, -, -, -
             -, -, -, -, S, -, -, -, O, -
             -, -, O, -, M, -, -, -, -, -
             -, -, -, -, N, -, -, -, S, -
             -, -, -, -, -, -, -, -, M, -
             E, W, -, O, -, -, -, -, N, -
             -, -, -, -, -, -, -, -, -, -
        ]
        """

        return StringPuzzleReader.puzzle(puzzleString: string)
    }
}
