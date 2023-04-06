//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 06/04/23.
//

import SwiftUI

struct SunscreenView: View {
    @ObservedObject private var c = SunscreenViewController()
    @State private var showAlert = false
    @State private var showLoading = false
    @State private var disableAvatarFaceInteraction = false
    let faceRGBData: (UInt8, UInt8, UInt8) = (248, 188, 140)
    let avatarFaceImage = UIImage(named: "avatar_face")!
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var qualityAlert: Alert {
        let filledArea = c.calculatePercentOfTotalFilledArea()
        if filledArea < 75 {
            return Alert(
                title: Text("Oops"),
                message: Text("You have filled only \(filledArea)% of the face. In that way, the sun can attack a good part of the skin, let's try again!"),
                dismissButton: .default(Text("Try Again!")) {
                    c.restartValues()
                }
            )
        }
        return Alert(
            title: Text("Very Good!!"),
            message: Text("You rached \(filledArea)% of the face!"),
            dismissButton: .default(Text("Continue!")) {
                disableAvatarFaceInteraction = true
            }
        )
    }

    var avatarFace: some View {
        Image(uiImage: avatarFaceImage)
            .gesture(
                DragGesture()
                    .onChanged {
                        value in
                        c.didDrag(
                            on: Location(value.location),
                            finishInk: {
                                DispatchQueue.main.async {
                                    showLoading = true
                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                                        calculatePixels()
                                        showLoading = false
                                        showAlert = true
                                    }
                                }
                            }
                        )
                    }
            )
            .overlay {
                ForEach(c.points) { point in
                    SunscreenTexture(point: point)
                }
            }
    }
    
    var body: some View {
        ZStack {
            avatarFace.disabled(disableAvatarFaceInteraction)
            GeometryReader { geo in
                Text("Remaining ink: \(c.remainingInk)")
                    .position(x: geo.size.width * 0.08, y: geo.size.height * 0.1)
            }
        }
        .blur(radius: showLoading ? 5 : 0)
        .overlay {
            if showLoading {
                ProgressView()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)
                    .position(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
            }
        }
        .alert(isPresented: $showAlert) {
            return qualityAlert
        }
        .onAppear {
            DispatchQueue.main.async {
                showLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    c.updateFilledStartArea(with: avatarFaceImage.pixelLocations(from: faceRGBData))
                    showLoading = false
                }
            }
        }
        .onReceive(timer) { _ in c.decreasePointsOpacity() }
    }
    
    func calculatePixels()  {
        if #available(iOS 16.0, *) {
            let renderer = ImageRenderer(content: avatarFace)
            if let uiimage = renderer.uiImage {
                c.updateFilledfinishArea(with: uiimage.pixelLocations(from: faceRGBData))
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct SunscreenView_Previews: PreviewProvider {
    static var previews: some View {
        SunscreenView()
    }
}
