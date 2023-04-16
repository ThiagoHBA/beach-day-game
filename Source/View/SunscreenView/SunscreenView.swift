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
    let faceRGBData: (UInt8, UInt8, UInt8) = (237, 206, 190)
    let avatarFaceImage = UIImage(named: "avatar_face1")!
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
            .resizable()
            .frame(
                width: UIScreen.main.bounds.width - 400,
                height: UIScreen.main.bounds.height
            )
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
                                        c.updateFilledfinishArea(with: calculatePixels())
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
            Image("room")
                .blur(radius: 5)
            
            avatarFace.disabled(disableAvatarFaceInteraction)
                .overlay {
                    Text("Remaining Ink: \(c.remainingInk)")
                        .bold()
                        .font(Font.system(.title))
                        .position(x: -45, y: 80)
                }
            
            SpeakBalloon(
                interaction: c.currentInteraction,
                interactionOver: c.updateInteractionIndex,
                showing: c.ballonIsShowing
            ).frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
        
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
                    c.updateFilledStartArea(with: calculatePixels())
                    showLoading = false
                    c.showInteraction()
                }
            }
        }
        .onReceive(timer) { _ in c.decreasePointsOpacity() }
    }
    
    func calculatePixels() -> Set<Location> {
        if #available(iOS 16.0, *) {
            let renderer = ImageRenderer(content: avatarFace)
            if let uiimage = renderer.uiImage {
                return uiimage.pixelLocations(from: faceRGBData)
            }
        }
        return Set<Location>()
    }
}

struct SunscreenView_Previews: PreviewProvider {
    static var previews: some View {
        SunscreenView()
            .previewDevice(PreviewDevice(rawValue: "iPad (10th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
        
        SunscreenView()
            .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
        
        SunscreenView()
            .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
        
        SunscreenView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
