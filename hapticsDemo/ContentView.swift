//
//  ContentView.swift
//  hapticsDemo
//
//  Created by Tyler Lawrence on 2/8/22.
//

import SwiftUI
import CoreHaptics

// custom button view for haptics
struct HapticsButtonView: View {
    
    @State var hapticLabel: String = ""
    @State var color: Color
    
    var body: some View{
        ZStack{
            Circle()
                .foregroundColor(color)
            Text(hapticLabel)
                .foregroundColor(.white)
        }
    }
}

struct ContentView: View {
    
    var body: some View {
        Text("Hello, World!")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
