//
//  InterfaceController.swift
//  WatchKit2-Sample-AudioRecording WatchKit Extension
//
//  Created by XuQing on 15/7/12.
//  Copyright © 2015年 XuQing1001. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func presentAudioRecordingUI() {

        let filePaths = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentDirectory,
            NSSearchPathDomainMask.UserDomainMask,
            true)
        let documentDir = filePaths.first!
        let filePath = documentDir + "/rec.m4a"
        let fileUrl = NSURL.fileURLWithPath(filePath)
        print("filePath:\(filePath) fileUrl:\(filePath)")
        
        // 录音参数
        let audioOptions = [
            WKAudioRecorderControllerOptionsActionTitleKey  : "保存后播放",
            WKAudioRecorderControllerOptionsAlwaysShowActionTitleKey : false,
            WKAudioRecorderControllerOptionsAutorecordKey: false,
            WKAudioRecorderControllerOptionsMaximumDurationKey: NSTimeInterval.infinity
        ]
        // 弹出录音界面，保存到指定URL
        self.presentAudioRecorderControllerWithOutputURL(
            fileUrl,
            preset: WKAudioRecorderPreset.NarrowBandSpeech,
            options: audioOptions as [NSObject : AnyObject]) { (didSave, error) -> Void in
                print("didSave:\(didSave), error:\(error)")
                if (didSave) {
                    // 保存后弹出播放界面，播放URL对应的音频文件
                    self.presentMediaPlayerControllerWithURL(
                        fileUrl,
                        options: nil) { (didPlayToEnd, endTime, error) -> Void in
                            
                            print("didPlayToEnd:\(didPlayToEnd), endTime:\(endTime), error:\(error)")
                    }
                }
        }
    }
}
