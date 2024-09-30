//
//  BattleshipsPuzzleCreatorApp.swift
//  BattleshipsPuzzleCreator
//
//  Created by Hasan Edain on 9/29/24.
//

import SwiftUI

@main
struct BattleshipsPuzzleCreatorApp: App {
    @StateObject var puzzle: Puzzle = Puzzle.emptyPuzzle(width: 10, height: 10)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(puzzle)
        }
    }
}
