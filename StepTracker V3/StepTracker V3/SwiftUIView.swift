//
//  SwiftUIView.swift
//  StepTracker V3
//
//  Created by taih on 12/4/22.
//

import SwiftUI
import CoreMotion

struct SwiftUIView: View {
    
    private let pedometer: CMPedometer = CMPedometer()
    
    @State private var steps: Int?
    
    private var isPedometerAvailable: Bool {
        return CMPedometer.isPedometerEventTrackingAvailable() && CMPedometer.isDistanceAvailable() && CMPedometer.isStepCountingAvailable()
    }
    
    private func initPedometer(){
        if (isPedometerAvailable) {
            
            guard let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) else{
                return
            }
                    
            pedometer.queryPedometerData(from: startDate, to: Date()) { [self] (data, error) in
                
                guard let data = data, error == nil else {return}
                
                self.steps = data.numberOfSteps.intValue
            }
        }
    }
    
    var body: some View {
        
        Text(steps != nil ? "\(steps!)" : "")
        
            .onAppear() {
                initPedometer()
            }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
