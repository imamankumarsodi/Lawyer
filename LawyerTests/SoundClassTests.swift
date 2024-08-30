//
//  SoundClassTests.swift
//  LawyerTests
//
//  Created by Aman Kumar on 20/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import XCTest
import AVFoundation
@testable import Lawyer
class SoundClassTests: XCTestCase {
    
    private var player: AVAudioPlayer?
    private var soundManager:SoundProtocol?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
      
        if self.player == nil {
            self.player = AVAudioPlayer()
        }
        
        if self.soundManager == nil {
            self.soundManager = SoundClass.shared
        }
        
    }
    
    func test_should_make_sure_that_sound_play(){
        XCTAssertNotNil(self.soundManager?.playSound("Judges_Gavel.mp3"), "Sound is playing successfully...")
    }
    
    
    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
}
