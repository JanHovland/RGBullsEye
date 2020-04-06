//
//  ContentView.swift
//  RGBullsEye
//
//  Created by Jan Hovland on 01/04/2020.
//  Copyright © 2020 Jan Hovland. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double

    @State var showAlert = false

    /// <#Description#>
    /// - Returns: <#description#>
    func computeScore() -> Int {
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
        return Int((1.0 - diff) * 100.0 + 0.5)
    }

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Color(red: rTarget, green: gTarget, blue: bTarget)
                    //                    Text("Match this color")
                    self.showAlert ? Text("R: \(Int(rTarget * 255.0))" + " G: \(Int(gTarget * 255.0))"
                        + " B: \(Int(bTarget * 255.0))")
                        : Text("Match this color")
                }

                VStack {
                    ZStack(alignment: .center) {
                        Color(red: rGuess, green: gGuess, blue: bGuess)
                        Text("60")
                            .padding(.all, 5)
                            .background(Color.white)
                            .mask(Circle())
                            .foregroundColor(.black)
                    }
                    Text("R: 127  G: 127  B: 127")
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
            Button(action: {
                self.showAlert = true
            }) {
                Text("Hit me!")

            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Your Score"),
                      message: Text(String(computeScore())))
            }
            .padding(.horizontal)

            VStack {
                SliderSetting(value: $rGuess, textColor: .red)
                SliderSetting(value: $gGuess, textColor: .green)
                SliderSetting(value: $bGuess, textColor: .blue)
            }
            .padding(.vertical)
            .padding(.horizontal)
        }
    }

}

struct SliderSetting: View {
    @Binding var value: Double
    var textColor: Color
    var body: some View {
        HStack {
            Text("0").foregroundColor(textColor)
            Slider(value: $value)
                .background(textColor)
                .cornerRadius(10)
            Text("255").foregroundColor(textColor)
        }
        .padding(.horizontal)
    }
}
