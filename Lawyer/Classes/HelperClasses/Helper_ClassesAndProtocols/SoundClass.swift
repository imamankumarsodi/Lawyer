//
//  SoundClass.swift
//  Lawyer
//
//  Created by Aman Kumar on 18/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import AVFoundation
class SoundClass: SoundProtocol {
    
    //TODO: Singleton object
    static let shared = SoundClass()
    private init() {}
    
    var player: AVAudioPlayer?
    
    //TODO: Play sounds
    func playSound(_ fileName: String) {
        
        let path = Bundle.main.path(forResource: fileName, ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    
}
