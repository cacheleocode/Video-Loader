//
//  ViewController.swift
//  Video Loader
//
//  Created by DOMINGUEZ, LEO on 11/28/18.
//  Copyright © 2018 mopro. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import QuartzCore

class ViewController: UIViewController {
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var keyartView: UIImageView!
    @IBOutlet weak var logoLabelView: UILabel!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var metadataView: UILabel!
    @IBOutlet weak var loadingbarView: UIImageView!
    @IBOutlet weak var labelVersion: UILabel!
    
    // dispatch queue
    
    let queue = DispatchQueue(label: "queue", attributes: .concurrent)
    
    var pendingTask: DispatchWorkItem?
    var pendingTask2: DispatchWorkItem?
    var pendingTask3: DispatchWorkItem?
    
    // version
    
    var version: String?
    
    // player layers
    
    var playerLayer: AVPlayerLayer?
    
    // content
    
    let channelArrays = Array(repeating: [
        "amc",
        "cbs",
        "cnn",
        "csn",
        "espn",
        "fox"
        ], count: 50)
    
    let channelKeyartArrays = Array(repeating: [
        "keyart_amc",
        "keyart_cbs",
        "keyart_cnn",
        "keyart_csn",
        "keyart_espn",
        "keyart_fox"
        ], count: 50)
    
    let channelLogoArrays = Array(repeating: [
        "logo_amc",
        "logo_cbs",
        "logo_cnn",
        "logo_csn",
        "logo_espn",
        "logo_fox"
        ], count: 50)
    
    var channelTitleArrays = Array(repeating: [
        "The Walking Dead",
        "The Talk",
        "State of the Union",
        "MIL vs SAC",
        "UCLA vs AZW",
        "Empire"
        ], count: 50)
    
    var channelMetadataArrays = Array(repeating: [
        "S2 E7 | The Other Side",
        "S7 EP182 | Actress Salma Hayek",
        "S77 E2 | Gary Johnson",
        "2017",
        "2017",
        "S2 E3 | Bout that"
        ], count: 50)
    
    var channels = [String]()
    var channelKeyarts = [String]()
    var channelLogos = [String]()
    var channelTitles = [String]()
    var channelMetadatas = [String]()
    
    // mode
    
    var surfing = false
    
    // emulate lag
    
    var randomNum: UInt32?
    var someInt: Int?
    var someDouble: Double?
    var randomTime: TimeInterval?
    var someCMTime: CMTime?
    
    // loading bar
    
    var loading_0: UIImage!
    var loading_1: UIImage!
    var loading_2: UIImage!
    var loading_3: UIImage!
    var loading_4: UIImage!
    var loading_5: UIImage!
    var loading_6: UIImage!
    var loading_7: UIImage!
    var loading_8: UIImage!
    var loading_9: UIImage!
    var loading_10: UIImage!
    var loading_11: UIImage!
    var loading_12: UIImage!
    var loading_13: UIImage!
    var loading_14: UIImage!
    var loading_15: UIImage!
    var loading_16: UIImage!
    var loading_17: UIImage!
    var loading_18: UIImage!
    var loading_19: UIImage!
    var loading_20: UIImage!
    var loading_21: UIImage!
    var loading_22: UIImage!
    var loading_23: UIImage!
    var loading_24: UIImage!
    var loading_25: UIImage!
    var loading_26: UIImage!
    var loading_27: UIImage!
    var loading_28: UIImage!
    var loading_29: UIImage!
    var loading_30: UIImage!
    var loading_31: UIImage!
    var loading_32: UIImage!
    var loading_33: UIImage!
    var loading_34: UIImage!
    var loading_35: UIImage!
    var loading_36: UIImage!
    var loading_37: UIImage!
    var loading_38: UIImage!
    var loading_39: UIImage!
    var loading_40: UIImage!
    var loading_41: UIImage!
    var loading_42: UIImage!
    var loading_43: UIImage!
    var loading_44: UIImage!
    var loading_45: UIImage!
    var images: [UIImage]!
    var animatedImage: UIImage!
    
    // actual players
    
    var player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "commercials", ofType:"mp4")!))
    
    // current channel
    
    var currentChannel: String!
    
    // fake index
    
    var fakeIndex: Int!
    
    var logoViewFrameOriginYInitial: CGFloat!
    
    var lastDirection: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        version = "motionA"

        // video
        
        playerLayer = AVPlayerLayer(player: self.player)
        playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer!.frame = self.videoView.frame
        playerLayer?.isHidden = false
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                self.player.seek(to: CMTime.zero)
                self.player.play()
            }
        })
        
        /*
        // random time
        self.randomNum = arc4random_uniform(15) // range
        self.someInt = Int(self.randomNum!)
        self.someDouble = Double(self.someInt!) / 10
        self.someCMTime = CMTime(seconds: someDouble!, preferredTimescale: 90000)
        
        debugPrint(self.player.currentItem!.asset.duration)
        
        if ((self.someCMTime?.seconds)! > self.player.currentItem!.asset.duration.seconds) {
            debugPrint("too much!")
        } else {
            debugPrint(self.someCMTime!.seconds)
        }
        */
        
        self.player.isMuted = false

        self.player.play()
        
        
        self.videoView.layer.addSublayer(playerLayer!)
        
        // resume playback upon app focus
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForegroundNotification), name: UIApplication.willEnterForegroundNotification , object: nil)
        
        // initial appearance
        self.labelVersion.text = self.version
        
        self.labelVersion.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -4)
        // self.labelVersion.frame.offsetBy(dx: 0, dy: -40)
        self.labelVersion.layer.position = CGPoint(x: 80, y: 80)
        
        // loading view
        self.loadingView.alpha = 0.0
        self.keyartView.alpha = 0.0
        self.logoLabelView.alpha = 0.0
        self.logoView.alpha = 1.0
        self.logoViewFrameOriginYInitial = self.logoView.frame.origin.y
        self.titleView.alpha = 0.0
        self.metadataView.alpha = 0.0
        self.loadingbarView.alpha = 0.0
        
        // fake index
        self.fakeIndex = 149
        
        // fake populate infinite loop
        
        for array in channelArrays {
            channels += array
        }
        
        for array in channelKeyartArrays {
            channelKeyarts += array
        }
        
        for array in channelLogoArrays {
            channelLogos += array
        }
        
        for array in channelTitleArrays {
            channelTitles += array
        }
        
        for array in channelMetadataArrays {
            channelMetadatas += array
        }
        
        // loading bar
        
        loading_0 = UIImage(named: "videoloadingbar_loop_00000")
        loading_1 = UIImage(named: "videoloadingbar_loop_00001")
        loading_2 = UIImage(named: "videoloadingbar_loop_00002")
        loading_3 = UIImage(named: "videoloadingbar_loop_00003")
        loading_4 = UIImage(named: "videoloadingbar_loop_00004")
        loading_5 = UIImage(named: "videoloadingbar_loop_00005")
        loading_6 = UIImage(named: "videoloadingbar_loop_00006")
        loading_7 = UIImage(named: "videoloadingbar_loop_00007")
        loading_8 = UIImage(named: "videoloadingbar_loop_00008")
        loading_9 = UIImage(named: "videoloadingbar_loop_00009")
        loading_10 = UIImage(named: "videoloadingbar_loop_00010")
        loading_11 = UIImage(named: "videoloadingbar_loop_00011")
        loading_12 = UIImage(named: "videoloadingbar_loop_00012")
        loading_13 = UIImage(named: "videoloadingbar_loop_00013")
        loading_14 = UIImage(named: "videoloadingbar_loop_00014")
        loading_15 = UIImage(named: "videoloadingbar_loop_00015")
        loading_16 = UIImage(named: "videoloadingbar_loop_00016")
        loading_17 = UIImage(named: "videoloadingbar_loop_00017")
        loading_18 = UIImage(named: "videoloadingbar_loop_00018")
        loading_19 = UIImage(named: "videoloadingbar_loop_00019")
        loading_20 = UIImage(named: "videoloadingbar_loop_00020")
        loading_21 = UIImage(named: "videoloadingbar_loop_00021")
        loading_22 = UIImage(named: "videoloadingbar_loop_00022")
        loading_23 = UIImage(named: "videoloadingbar_loop_00023")
        loading_24 = UIImage(named: "videoloadingbar_loop_00024")
        loading_25 = UIImage(named: "videoloadingbar_loop_00025")
        loading_26 = UIImage(named: "videoloadingbar_loop_00026")
        loading_27 = UIImage(named: "videoloadingbar_loop_00027")
        loading_28 = UIImage(named: "videoloadingbar_loop_00028")
        loading_29 = UIImage(named: "videoloadingbar_loop_00029")
        loading_30 = UIImage(named: "videoloadingbar_loop_00030")
        loading_31 = UIImage(named: "videoloadingbar_loop_00031")
        loading_32 = UIImage(named: "videoloadingbar_loop_00032")
        loading_33 = UIImage(named: "videoloadingbar_loop_00033")
        loading_34 = UIImage(named: "videoloadingbar_loop_00034")
        loading_35 = UIImage(named: "videoloadingbar_loop_00035")
        loading_36 = UIImage(named: "videoloadingbar_loop_00036")
        loading_37 = UIImage(named: "videoloadingbar_loop_00037")
        loading_38 = UIImage(named: "videoloadingbar_loop_00038")
        loading_39 = UIImage(named: "videoloadingbar_loop_00039")
        loading_40 = UIImage(named: "videoloadingbar_loop_00040")
        loading_41 = UIImage(named: "videoloadingbar_loop_00041")
        loading_42 = UIImage(named: "videoloadingbar_loop_00042")
        loading_43 = UIImage(named: "videoloadingbar_loop_00043")
        loading_44 = UIImage(named: "videoloadingbar_loop_00044")
        loading_45 = UIImage(named: "videoloadingbar_loop_00045")
        
        images = [
            loading_0,
            loading_1,
            loading_2,
            loading_3,
            loading_4,
            loading_5,
            loading_6,
            loading_7,
            loading_8,
            loading_9,
            loading_10,
            loading_11,
            loading_12,
            loading_13,
            loading_14,
            loading_15,
            loading_16,
            loading_17,
            loading_18,
            loading_19,
            loading_20,
            loading_21,
            loading_22,
            loading_23,
            loading_24,
            loading_25,
            loading_26,
            loading_27,
            loading_28,
            loading_29,
            loading_30,
            loading_31,
            loading_32,
            loading_33,
            loading_34,
            loading_35,
            loading_36,
            loading_37,
            loading_38,
            loading_39,
            loading_40,
            loading_41,
            loading_42,
            loading_43,
            loading_44,
            loading_45
        ]
        
        animatedImage = UIImage.animatedImage(with: images, duration: 1.3)
        loadingbarView.image = animatedImage
        loadingbarView.layer.cornerRadius = 10
    }
    
    @objc func appWillEnterForegroundNotification() {
        playerLayer?.isHidden = false
        playerLayer?.player?.isMuted = false
        playerLayer?.player?.play()
     }
    
    func doRestartTimer() {
        debugPrint("doRestartTimer")
        pendingTask2 = DispatchWorkItem {
            self.doHide()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(2000), execute: self.pendingTask2!)
    }
    
    func doInvalidateTimer() {
        debugPrint("doInvalidateTimer")
        pendingTask2?.cancel()
        
        self.doShow(direction: self.lastDirection)
    }
    
    func doShow(direction: String) {
        pendingTask = DispatchWorkItem {
            // populate loading view
            
            self.keyartView.image = UIImage(named: String(describing: self.channelKeyarts[self.fakeIndex]))
            self.logoLabelView.text = String(describing: self.channels[self.fakeIndex])
            self.logoView.image = UIImage(named: String(describing: self.channelLogos[self.fakeIndex]))
            self.titleView.text = String(describing: self.channelTitles[self.fakeIndex])
            self.metadataView.text = String(describing: self.channelMetadatas[self.fakeIndex])
            
            
            if (self.version == "motionA") {
            
            self.logoLabelView.alpha = 0.0
            self.logoView.alpha = 0.0
            
            self.keyartView.alpha = 0.0
            self.titleView.alpha = 0.0
            self.loadingbarView.alpha = 0.0
            self.metadataView.alpha = 0.0
            
            
            if (direction == "up") {
                self.logoView.frame.origin.y = self.logoViewFrameOriginYInitial - 80
            }
            else if (direction == "down") {
                self.logoView.frame.origin.y = self.logoViewFrameOriginYInitial + 80
            }
            
            
            
            UIView.animate(withDuration: 0.3,
                           delay: 0.0,
                           options: [.curveEaseOut],
                           animations: {
                self.loadingView.alpha = 1.0
                self.logoView.alpha = 1.0
                self.logoView.frame.origin.y = self.logoViewFrameOriginYInitial
            }, completion: { (finished: Bool) in
                self.doPopulate()
            })
                
            } else {
                self.loadingView.alpha = 1.0
                self.logoView.alpha = 1.0
                self.logoView.frame.origin.y = self.logoViewFrameOriginYInitial
                
                self.doPopulate()
            }
        }
        
        DispatchQueue.main.async(execute: self.pendingTask!)
    }
    
    func doHide() {
    
        // emulate loading
        self.randomNum = arc4random_uniform(15) // range
        self.someInt = Int(self.randomNum!)
        self.someDouble = Double(self.someInt!) / 10
        
        if (self.someDouble! < 2.0) {
            self.someDouble! = 2.0
        }
        
        UIView.animate(withDuration: 0.3, delay: self.someDouble!, animations: {
            self.loadingView.alpha = 0.0
            
            self.player.isMuted = false
        }, completion: nil)
    
    }
    
    func doPopulate() {
        // emulate loading
        self.randomNum = arc4random_uniform(15) // range
        self.someInt = Int(self.randomNum!)
        self.someDouble = Double(self.someInt!) / 10
        
        if (self.someDouble! < 2.0) {
            self.someDouble! = 2.0
        }
        
        self.titleView.alpha = 0.0
        self.loadingbarView.alpha = 0.0
        self.metadataView.alpha = 0.0
        self.keyartView.alpha = 0.0
        
        // self.loadingbarView.alpha = 1.0
        // self.loadingbarView.startAnimating()
        
        UIView.animate(withDuration: 0.3, delay: 1.0, options: [.curveEaseOut], animations: {
            self.titleView.alpha = 1.0
            self.metadataView.alpha = 1.0
            self.loadingbarView.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 1.0, options: [.curveEaseOut], animations: {
            
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 1.6, options: [.curveEaseOut], animations: {
            
            self.player.isMuted = true
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: self.someDouble!, options: [.curveEaseOut], animations: {
            self.keyartView.alpha = 1.0
        }, completion: nil)
    }
    
    func doScroll(direction: String) {
        if(direction == "up") {
            self.fakeIndex = self.fakeIndex + 1
            doShow(direction: "up")
         } else if(direction == "down") {
            self.fakeIndex = self.fakeIndex - 1
            doShow(direction: "down")
         }
    }
    
    func doToggleVersion () {
        if (version == "motionA") {
            self.version = "simple"
            
        } else {
            self.version = "motionA"
        }
        
        self.labelVersion.text = self.version
    }
    
    func doLogo() {
        
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        if(presses.first?.type == UIPress.PressType.upArrow) {
            debugPrint("up arrow began")
            self.fakeIndex = self.fakeIndex + 1
            self.lastDirection = "up"
        } else if(presses.first?.type == UIPress.PressType.downArrow) {
            debugPrint("down arrow began")
            self.fakeIndex = self.fakeIndex - 1
            self.lastDirection = "down"
        } else if(presses.first?.type == UIPress.PressType.leftArrow) {
            doToggleVersion()
        }
        
        // Presses in progress - !ended, !cancelled, just invalidate it
        print("Invalidate auto lock timer")
        self.doInvalidateTimer()
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        // Presses ended || cancelled, restart timer
        print("Restart auto lock timer")
        self.doRestartTimer()
    }
    
/*
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        
        
        if(presses.first?.type == UIPress.PressType.upArrow) {
            debugPrint("up arrow began")
            self.fakeIndex = self.fakeIndex + 1
            debugPrint(self.fakeIndex)
            self.lastDirection = "up"
            self.doShow(direction: "up")
        } else if(presses.first?.type == UIPress.PressType.downArrow) {
            debugPrint("down arrow began")
            self.fakeIndex = self.fakeIndex - 1
            debugPrint(self.fakeIndex)
            self.lastDirection = "down"
            self.doShow(direction: "down")
        } else if(presses.first?.type == UIPress.PressType.leftArrow) {
            doToggleVersion()
        }
    }
 
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        self.surfing = false
    }
 */
}

