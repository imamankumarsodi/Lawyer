//
//  UploadDocumentVC+AVAudioRecorderDelegate.swift
//  Lawyer
//
//  Created by Aman Kumar on 22/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
extension UploadDocumentVC:AVAudioRecorderDelegate,AVAudioPlayerDelegate{
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag
        {
            finishAudioRecording(success: false)
        }
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            stopAudioPlayer()
        }else {
            // Playing interrupted by other reasons like call coming, the sound has not finished playing.
            stopAudioPlayer()
        }
    }
}
