//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 06/04/23.
//

import SwiftUI

struct SunscreenView: View {
    @EnvironmentObject var router: Router
    @ObservedObject private var c = SunscreenViewController()
    @State private var showAlert = false
    @State private var showLoading = false
    @State private var disableAvatarFaceInteraction = false
    @Environment(\.mainWindowSize) var windowSize
    let faceRGBData: (UInt8, UInt8, UInt8) = (239, 212, 197)
    let avatarFaceImage = UIImage(named: "avatar_zoomed")!
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
                router.nextInteraction()
            }
        )
    }
    
    var avatarFace: some View {
        Image(uiImage: avatarFaceImage)
            .resizable()
            .frame(width: windowSize.width, height: windowSize.height)
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
                .resizable()
                .frame(width: windowSize.width, height: windowSize.height)
                .scaleEffect(2)
                .blur(radius: 5)
            
            avatarFace.disabled(disableAvatarFaceInteraction)
                .overlay {
                    VStack {
                        Text("Remaining")
                            .bold()
                            .font(.title3)
                        Text("\(NSString(format: "%.2f", Double(c.remainingInk)))/ 5.00 ml")
                            .bold()
                            .font(Font.system(.title))
                    }
                    .position(x: 150, y: 150)
                    .shadow(radius: 2)
                }
            SpeakBalloon(
                interaction: c.currentInteraction,
                interactionOver: c.updateInteractionIndex,
                showing: c.ballonIsShowing
            )
        }
        .blur(radius: showLoading ? 5 : 0)
        .overlay {
            if showLoading {
                ProgressView()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)
                    .position(x: windowSize.width * 0.5, y: windowSize.height * 0.5)
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
        .position(x: windowSize.width * 0.5, y: windowSize.height * 0.5)
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
