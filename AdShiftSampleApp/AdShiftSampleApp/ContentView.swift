//
//  ContentView.swift
//  adshiftSampleApp
//
//  Created by Matt on 6/5/25.
//

import SwiftUI
import AdshiftIOS
import AppTrackingTransparency
import AdSupport

struct SampleView: View {
    @State private var statusMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 20) {
                HStack(spacing: 15) {
                    Button("Track Event") {
                        if !Adshift.shared.isStarted() {
                            statusMessage = "SDK is not started. Couldn't track the event."
                        } else {
                            Adshift.shared.trackEvent(eventName: .customEvent("Custom Event"))
                            Adshift.shared.trackEvent(eventName: .achievementUnlocked)
                            statusMessage = "Custom and achievement events tracked."
                        }
                    }

                    Button("Start SDK") {
                        Adshift.shared.start()
                        statusMessage = Adshift.shared.isStarted()
                            ? "SDK started successfully."
                            : "Couldn't start SDK. Check the API key."
                    }

                    Button("Stop SDK") {
                        Adshift.shared.stop()
                        statusMessage = "SDK stopped."
                    }

                    Button("Track Purchase") {
                        if !Adshift.shared.isStarted() {
                            statusMessage = "SDK is not started. \nCouldn't track the purchase."
                        } else {
                            Adshift.shared.trackPurchase(productId: "1", price: 3.99, currency: "USD", token: "123")
                            Adshift.shared.trackEvent(eventName: .purchase)
                            statusMessage = "Purchase tracked."
                        }
                    }
                    .lineLimit(2)
                }
                .padding(.horizontal, 0)
                .buttonStyle(.borderedProminent)

                Spacer()

                ScrollView {
                    Text(statusMessage)
                        .multilineTextAlignment(.center)
                        .padding()
                }

                Spacer()
            }
            .padding()
            .onOpenURL { url in
                Adshift.shared.setDeeplinkListener(url: url)
                statusMessage = "Deeplink opened:\n\(url.absoluteString)"
            }
            .onAppear {
                requestTrackingPermission()
            }
        }
    }

    private func requestTrackingPermission() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .authorized:
                        let idfa = ASIdentifierManager.shared().advertisingIdentifier
                        debugPrint("IDFA: \(idfa.uuidString)")
                    case .denied, .restricted, .notDetermined:
                        debugPrint("Tracking not authorized.")
                    @unknown default:
                        debugPrint("Unknown tracking status.")
                    }
                }
            } else {
                let idfa = ASIdentifierManager.shared().advertisingIdentifier
                debugPrint("IDFA (pre-iOS 14): \(idfa.uuidString)")
            }
        }
    }
}

#Preview {
    SampleView()
}

    
