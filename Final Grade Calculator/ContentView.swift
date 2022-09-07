//
//  ContentView.swift
//  Final Grade Calculator
//
//  Created by Chris Markiewicz on 9/1/22.
//

import SwiftUI

struct ContentView: View {
    @State private var currentGradeTxtField = ""
    @State private var finalWeightTxtField = ""
    @State private var desiredGrade = 0.0
    @State private var requiredGrade = 0
    var body: some View {
        ZStack{
            VStack {
                CustomText(text: "Final Grade Calculator")
                CustomTextField(placeholder: "Current Grade", variable: $currentGradeTxtField)
                CustomTextField(placeholder: "final Weight", variable: $finalWeightTxtField)
                Picker("Desired Semester Grade", selection: $desiredGrade) {
                    Text("A").tag(90.0)
                    Text("B").tag(80.0)
                    Text("C").tag(70.0)
                    Text("D").tag(60.0)
                    Text("F").tag(50.0)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                Text("required grade on Final")
                CustomText(text:String(requiredGrade))
            }
            .onChange(of: desiredGrade, perform: { newValue in
                calculate()
            })
        }
        .background (requiredGrade > 100 ? Color.red : Color.green.opacity(requiredGrade > 0 ? 1.0 : 0.0))
    }
    func calculate() {
        if let currentGrade = Double(currentGradeTxtField) {
            if let finalWeight = Double(finalWeightTxtField) {
                if finalWeight < 100 && finalWeight > 0 {
                    let finalPercentage = finalWeight/100.0
                    requiredGrade = Int(max(0.0, (desiredGrade - (currentGrade * (1.0 - finalPercentage))) / finalPercentage) + 0.5)
                }
            }
        }
    }
}
struct CustomText: View {
    let text : String
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
    }
}
struct CustomTextField: View {
    let placeholder : String
    let variable : Binding<String>
    var body: some View {
        TextField(placeholder, text: variable)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .multilineTextAlignment(.center)
            .frame(width: 200, height: 30, alignment: .center)
            .font(.body)
            .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
