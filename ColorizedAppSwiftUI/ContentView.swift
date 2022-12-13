//
//  ContentView.swift
//  ColorizedAppSwiftUI
//
//  Created by Айтолкун Анарбекова on 13/12/22.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    @State private var textOfTextField = ""
    
    
    var body: some View {
        ZStack (alignment: .top) {
            Color(
                red: 87/255,
                green: 85/255,
                blue: 153/255
            ).ignoresSafeArea()
            HStack {
                GeometryReader { geo in
                    
                    VStack (alignment: .center){
                        RoundedRectangle(cornerRadius: 15)
                            .fill(
                                Color(
                                    red: redSliderValue / 255,
                                    green: greenSliderValue / 255,
                                    blue: blueSliderValue / 255
                                )
                            )
                            .frame(width: geo.size.width * 0.92, height: 150)
                            .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 4)
                                .foregroundColor(.white))
                        
                        VStack {
                            
                            ColorSliderView(value: $redSliderValue, val: $textOfTextField, color: .red)
                            ColorSliderView(value: $greenSliderValue, val: $textOfTextField, color: .green)
                            ColorSliderView(value: $blueSliderValue, val: $textOfTextField, color: .blue)
                        }.padding()
                    }
                    
                }
                
            }
        }
        
    }
}


struct ColorSliderView: View {
    @FocusState var isInputActive: Bool
    @Binding var value: Double
    @Binding var val: String
    let color: Color
    
    var body: some View {
        HStack {
            VStack {
                Text("\(lround(value))").foregroundColor(.white)
                
            }
            
            Slider(value: $value, in: 0...255, step: 1)
                .tint(color)
            
            TextField("", text: $val)
                .bordered()
                .textFieldStyle(.roundedBorder)
                .focused($isInputActive)
                .keyboardType(.numberPad)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        
                        Button("Done") {
                            isInputActive = false
                        }
                    }
                }
            
        }
        
    }
    
    
}

struct BorderedViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 45, height: 30)
            .background(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.white)
            )
    }
}

extension TextField {
    func bordered() -> some View {
        modifier(BorderedViewModifier())
    }
}














struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
