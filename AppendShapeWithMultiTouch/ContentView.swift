//
//  ContentView.swift
//  AR1
//
//  Created by sabiche on 2023/01/27.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.addTapGesture()
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

extension ARView {
    func addTapGesture() {
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        tapGesture.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGesture)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        tapGesture.numberOfTouchesRequired = 2
        self.addGestureRecognizer(tapGesture)
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        tapGesture.numberOfTouchesRequired = 3
        self.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        // タップしたロケーションを取得
        let tapLocation = recognizer.location(in: self)
        // タップした位置に対応する3D空間上の平面とのレイキャスト結果を取得
        let raycastResults = raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .vertical)
        switch recognizer.numberOfTouches {
        case 1:
            let anchor = try! Experience.loadCircle()
            self.scene.anchors.append(anchor)
        case 3:
            let anchor = try! Experience.loadTriangle()
            self.scene.anchors.append(anchor)
        default:
            let anchor = try! Experience.loadBox()
            self.scene.anchors.append(anchor)
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
