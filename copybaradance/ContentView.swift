//
//  ContentView.swift
//  copybaradance
//

import SwiftUI
internal import Combine

struct ContentView: View {
    @State private var frameIndex = 0

    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    let capybaraFrames: [String] = [
        // Frame 0: Neutral stance
        "   ___\n  /o o\\\n (  -  )\n (     )\n   | |\n  /   \\",
        // Frame 1: Arms raised
        " \\  ___  /\n   /o o\\\n  (  -  )\n  (     )\n    | |\n    | |",
        // Frame 2: Lean left
        "  ___\n /o o\\\n(  -  )\n(     )\n  | |\n /   ",
        // Frame 3: Lean right
        "     ___\n    /o o\\\n   (  -  )\n   (     )\n     | |\n        \\",
        // Frame 4: Happy face
        "   ___\n  /^ ^\\\n (  w  )\n (     )\n   | |\n  /   \\",
    ]

    let notes = ["♩", "♪", "♫", "♬", "♩", "♪", "♫", "♬"]
    let noteColors: [Color] = [.yellow, .orange, .pink, .purple, .blue, .cyan, .green, .mint]

    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.12)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Capybara Dance Party")
                    .font(.title2.bold())
                    .foregroundStyle(.yellow)

                Text(capybaraFrames[frameIndex])
                    .font(.system(size: 24, weight: .regular, design: .monospaced))
                    .foregroundStyle(.green)
                    .multilineTextAlignment(.center)
                    .frame(width: 240, height: 150, alignment: .center)

                HStack(spacing: 10) {
                    ForEach(notes.indices, id: \.self) { i in
                        Text(notes[i])
                            .font(.title2)
                            .foregroundStyle(noteColors[i % noteColors.count])
                            .offset(y: (frameIndex + i) % 2 == 0 ? -6 : 6)
                            .animation(.easeInOut(duration: 0.4), value: frameIndex)
                    }
                }
            }
        }
        .onReceive(timer) { _ in
            frameIndex = (frameIndex + 1) % capybaraFrames.count
        }
    }
}

#Preview {
    ContentView()
}
