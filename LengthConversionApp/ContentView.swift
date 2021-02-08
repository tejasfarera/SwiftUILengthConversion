//
//  ContentView.swift
//  LengthConversionApp
//
//  Created by rails on 07/02/21.
//

import SwiftUI

enum Units: String, CaseIterable {
    case meter
    case yard
    case foot
    case inch
    
    func getValue() -> Double {
        switch self {
        case .meter:
            return 1.00000
        case .yard:
            return 1.09361
        case .foot:
            return 3.28084
        case .inch:
            return 39.3701
        }
    }
}

struct ContentView: View {
    
    @State private var length = ""
    @State private var selectedInputUnit = 0
    @State private var selectedOutputUnit = 0
    
    private let units: [Units] = [.meter, .yard, .foot, .inch]
    private var outputLength: Double {
        let inputedLength = Double(length) ?? 0
        let outputLength = (units[selectedOutputUnit].getValue() / units[selectedInputUnit].getValue()) * inputedLength
        return outputLength
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    TextField("Enter the length", text: $length)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: (Text("Select input unit"))) {
                    Picker(selection: $selectedInputUnit, label: Text(""), content: {
                        ForEach(0 ..< units.count) {
                            Text("\(units[$0].rawValue.uppercased())")
                        }
                    }).pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: (Text("Select Output unit"))) {
                    Picker(selection: $selectedOutputUnit, label: Text(""), content: {
                        ForEach(0 ..< units.count) {
                            Text("\(units[$0].rawValue.uppercased())")
                        }
                    }).pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Text("\(outputLength) \(units[selectedOutputUnit].rawValue.uppercased())")
                }
            }
            .navigationTitle("Length Conversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
