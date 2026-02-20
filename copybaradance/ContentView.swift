//
//  ContentView.swift
//  copybaradance
//

import SwiftUI
internal import Combine

struct ContentView: View {
    @State private var frameIndex = 0

    let timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()

    let notes = ["♩", "♪", "♫", "♬", "♩", "♪", "♫", "♬"]
    let noteColors: [Color] = [.yellow, .orange, .pink, .purple, .blue, .cyan, .green, .mint]

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("Capybara Dance Party")
                    .font(.title2.bold())
                    .foregroundStyle(.black)

                Image("capybara\(frameIndex + 1)")
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)

                HStack(spacing: 10) {
                    ForEach(notes.indices, id: \.self) { i in
                        Text(notes[i])
                            .font(.title2)
                            .foregroundStyle(noteColors[i % noteColors.count])
                            .offset(y: (frameIndex + i) % 2 == 0 ? -6 : 6)
                            .animation(.easeInOut(duration: 0.15), value: frameIndex)
                    }
                }
            }
        }
        .onReceive(timer) { _ in
            frameIndex = (frameIndex + 1) % 5
        }
    }
}

#Preview {
    ContentView()
}
