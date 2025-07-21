//
//  adshiftSampleAppApp.swift
//  adshiftSampleApp
//
//  Created by Matt on 6/5/25.
//

import SwiftUI
import AdshiftIOS
import AppTrackingTransparency
import AdSupport

@main
struct adshiftSampleAppApp: App {
    
    init() {
        Adshift.shared.setApiKey(apiKey: "[UNIQUE_API_KEY]")
        Adshift.shared.setCustomerUserId("[USER_ID]")
        Adshift.shared.setLogLevel(.debug)
    }
    
    var body: some Scene {
        WindowGroup {
            SampleView()
        }
    }
}
