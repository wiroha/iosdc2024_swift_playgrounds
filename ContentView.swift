import SwiftUI

struct ContentView: View {
    @State private var score = 0.0
    @State private var points: [CGPoint] = []
    @State private var isDrawing = false

    var body: some View {
        VStack {
            Text("Draw a circle!")
                .font(.largeTitle)
                .padding()

            Text("Score: \(score, specifier: "%.2f")")
                .font(.title)
                .padding()

            ZStack {
                Path { path in
                    if points.count > 1 {
                        path.addLines(points)
                    }
                }
                .stroke(Color.blue, lineWidth: 2)

                Color.clear
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                if !isDrawing {
                                    points = [value.location]
                                    isDrawing = true
                                } else {
                                    points.append(value.location)
                                }
                            }
                            .onEnded { _ in
                                if points.count > 2 {
                                    score = CircleAccuracyCalculator.calculateScore(from: points)
                                }
                                isDrawing = false
                            }
                    )
            }
            .background(Color.gray.opacity(0.2))
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            Button(action: {
                points = []
                score = 0.0
            }) {
                Text("Clear Circle")
                    .font(.title)
                    .padding()
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
