//
//  GenerateView.swift
//  BattleshipsPuzzleCreator
//
//  Created by Hasan Edain on 9/29/24.
//

import SwiftUI

struct GenerateView: View {
    @EnvironmentObject var puzzle: Puzzle
    @State var selectShipSetIndex: Int = 10
    @State var size: Float = 10
    @State var showWater: Bool = false

    @State var saveCountString: String = "0"
    @State var filenameString: String = "puzzle"

    var body: some View {
        VStack {
            HStack {
                PuzzleAndCluesView(showShips: true, showWater: showWater)
                PuzzleAndCluesView(showShips: false, showWater: showWater)
            }.padding()
            HStack {
                Picker(selection: $selectShipSetIndex, label: Text("Ship Set")) {
                    Text("1").tag(1)
                    Text("3").tag(3)
                    Text("6").tag(6)
                    Text("10").tag(10)
                    Text("15").tag(15)
                }
                .frame(width: 200)
                .padding(.trailing)
                Text("Size: \(Int(size))")
                Slider(value: $size, in: 6...25)
                    .frame(width: 200)
            }.padding()
            HStack {
                Text("File Name: ")
                TextField("puzzle", text: $filenameString)
                    .frame(width: 75)
            }
            HStack {
                Toggle("Show Water", isOn: $showWater)
                Button("Generate") {
                    generate()
                }
                Button("Save") {
                    save()
                }
                Text("Save Count:")
                TextField("0", text: $saveCountString)
                    .frame(width: 75)
            }
            .padding()
        }
    }

    func generate() {
        let sliderValue = Int(size)
        puzzle.clear()
        self.puzzle.width = sliderValue
        self.puzzle.height = sliderValue
        self.puzzle.tiles = Puzzle.emptyArray(width: sliderValue, height: sliderValue)
        let shipSet = ShipSet.setFor(number: selectShipSetIndex)
        puzzle.place(shipSet: shipSet)
    }

    @MainActor func save() {
        let rendererSolved = ImageRenderer(content: solvedPuzzleView)
        let redererPuzzle = ImageRenderer(content: puzzleView)

        var saveCount = 0
        if let mySaveCount = Int(saveCountString) {
            saveCount = mySaveCount
        }

        let homeURL = FileManager.default.homeDirectoryForCurrentUser
        let solvedUrl = homeURL.appending(path: "\(filenameString)_\(saveCount)_solved.pdf")
        print("Solved File: \(solvedUrl.absoluteString)")
        let unsolvedUrl = homeURL.appending(path: "\(filenameString)_\(saveCount)_puzzle.pdf")
        let textUrl = homeURL.appending(path: "\(filenameString)_\(saveCount)_puzzle.txt")
        saveText(url: textUrl)

        rendererSolved.render { size, renderInContext in
            var box = CGRect(
                origin: .zero,
                size: .init(width: CGFloat(puzzle.width*24 + 30), height: CGFloat(puzzle.height * 24 + 30))
            )

            guard let context = CGContext(solvedUrl as CFURL, mediaBox: &box, nil) else {
                return
            }

            context.beginPDFPage(nil)
            renderInContext(context)
            context.endPage()
            context.closePDF()
        }

        redererPuzzle.render { size, renderInContext in
            var box = CGRect(
                origin: .zero,
                size: .init(width: CGFloat(puzzle.width*24 + 30), height: CGFloat(puzzle.height*24 + 30))
            )

            guard let context = CGContext(unsolvedUrl as CFURL, mediaBox: &box, nil) else {
                return
            }

            context.beginPDFPage(nil)
            renderInContext(context)
            context.endPage()
            context.closePDF()
        }

        saveCount = saveCount + 1
        self.saveCountString = String(saveCount)
    }

    @ViewBuilder var solvedPuzzleView: some View {
        PuzzleAndCluesView(showShips: true, showWater: false)
            .environmentObject(puzzle)
    }

    @ViewBuilder var puzzleView: some View {
        PuzzleAndCluesView(showShips: false, showWater: false)
            .environmentObject(puzzle)
    }

    func saveText(url: URL) {
            // Create data to be saved
        let myString = puzzle.debugDescription
        guard let data = myString.data(using: .utf8) else {
            print("Unable to convert string to data")
            return
        }
            // Save the data
        do {
            try data.write(to: url)
            print("File saved: \(url.absoluteURL)")
        } catch {
                // Catch any errors
            print(error.localizedDescription)
        }
    }
}

#Preview {
    GenerateView()
        .environmentObject(Puzzle.emptyPuzzle(width: 10, height: 10))
}
