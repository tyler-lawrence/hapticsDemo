//
//  ContentView.swift
//  hapticsDemo
//
//  Created by Tyler Lawrence on 2/8/22.
//

import SwiftUI
import CoreHaptics

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
    
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        VStack{
            HapticsButtonView(hapticLabel: "error", color: .red)
                .onTapGesture(perform: errorHaptic)
            HapticsButtonView(hapticLabel: "warning", color: .yellow)
                .onTapGesture(perform: warningHaptic)
            HapticsButtonView(hapticLabel: "success", color: .green)
                .onTapGesture(perform: successHaptic)
            HapticsButtonView(hapticLabel: "custom", color: .blue)
                .onAppear(perform: prepareHaptics)
                .onTapGesture(perform: complexSuccess)
        }
    }
    
    // Simple UI Kit haptics
    func successHaptic(){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func warningHaptic(){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
    func errorHaptic(){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    // CoreHaptics
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
