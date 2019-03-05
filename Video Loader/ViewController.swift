import UIKit
import AVFoundation
import MediaPlayer
import QuartzCore

class ViewController: UIViewController {
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var keyartView: UIImageView!
    @IBOutlet weak var callsignView: UILabel!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var metadataView: UILabel!
    @IBOutlet weak var loadingbarView: UIImageView!
    @IBOutlet weak var versionView: UILabel!
    
    // dispatch queue
    
    let queue = DispatchQueue(label: "queue", attributes: .concurrent)
    var pendingTask: DispatchWorkItem?
    var pendingTask2: DispatchWorkItem?
    
    // version
    
    var version: String?
    
    // player layer
    
    var playerLayer: AVPlayerLayer?
    var playerLayer2: AVPlayerLayer?
    
    // content
    
    let channels = ["CBS", "ESPN"]
    
    let channelKeyarts = ["keyart_cbs", "keyart_espn"]
    
    let channelLogos = ["logo_cbs", "logo_espn"]
    
    var channelTitles = ["The Talk", "UCLA vs AZW"]
    
    var channelMetadatas = ["S7 EP182 | Actress Salma Hayek", "2017"]
    
    // mode
    
    var surfing = false
    
    // emulate lag
    
    var randomNum: UInt32?
    var someInt: Int?
    var someDouble: Double?
    var randomTime: TimeInterval?
    var someCMTime: CMTime?
    var randomDouble: Double?
    
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
    
    // actual player
    
    var player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "commercials", ofType:"mp4")!))
    var player2 = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "game", ofType:"mp4")!))
    
    // current channel
    
    var currentChannel: String!
    
    // fake index
    
    var fakeIndex: Int!
    
    var callsignViewFrameOriginYInitial: CGFloat!
    
    var logoViewFrameOriginYInitial: CGFloat!
    
    var callsignViewFrameOriginXInitial: CGFloat!
    
    var logoViewFrameOriginXInitial: CGFloat!
    
    var lastDirection: String!
    
    // timer
    
    var counter = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.version = "motionA"
        
        self.lastDirection = "up"

        // video
        
        playerLayer = AVPlayerLayer(player: self.player)
        playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer!.frame = self.videoView.frame
        playerLayer?.isHidden = false
        
        // loop video
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                self.player.seek(to: CMTime.zero)
                self.player.play()
            }
        })
        
        self.player.isMuted = false

        self.player.play()
        
        self.videoView.layer.addSublayer(playerLayer!)
        
        
        playerLayer2 = AVPlayerLayer(player: self.player2)
        playerLayer2?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer2!.frame = self.videoView.frame
        playerLayer2?.isHidden = true
        
        // loop video
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player2.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                self.player2.seek(to: CMTime.zero)
                self.player2.play()
            }
        })
        
        self.player2.isMuted = true
        
        self.player2.play()
        
        self.videoView.layer.addSublayer(playerLayer2!)
        
        // resume playback upon app focus
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForegroundNotification), name: UIApplication.willEnterForegroundNotification , object: nil)
        
        // initial appearance
        
        self.versionView.text = self.version
        self.versionView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / -4)
        self.versionView.layer.position = CGPoint(x: 150, y: 150)
        
        // loading view
        
        self.loadingView.alpha = 0.0
        self.keyartView.alpha = 0.0
        self.callsignView.alpha = 0.0
        self.callsignViewFrameOriginYInitial = self.callsignView.frame.origin.y
        self.callsignViewFrameOriginXInitial = self.callsignView.frame.origin.x
        self.logoView.alpha = 1.0
        self.logoViewFrameOriginYInitial = self.logoView.frame.origin.y
        self.logoViewFrameOriginXInitial = self.logoView.frame.origin.x
        self.titleView.alpha = 0.0
        self.metadataView.alpha = 0.0
        self.loadingbarView.alpha = 0.0
        
        // fake index
        self.fakeIndex = 0
   
        
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
        
        /*
        UIApplication.shared.beginReceivingRemoteControlEvents()
        self.becomeFirstResponder()
        debugPrint("isFirstResponder: \(self.isFirstResponder)")
        */
    }
    
    /*
    override func becomeFirstResponder() -> Bool {
        self.becomeFirstResponder()
        return true
    }
    */
    
    @objc func appWillEnterForegroundNotification() {
        playerLayer?.isHidden = false
        playerLayer?.player?.isMuted = false
        playerLayer?.player?.play()
     }
    
    // start timer
    @IBAction func timerStart(sender: UIPressesEvent) {
        timer.invalidate() // just in case this is triggered multiple times
        
        counter = 0
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    // stop timer
    @IBAction func timerCancel(sender: UIPressesEvent) {
        timer.invalidate()
        
        counter = 0
    }
    
    // called every time interval from the timer
    @objc func timerAction() {
        counter += 1
        debugPrint(counter)

    }
    
    func doRestartTimer() {
        pendingTask2 = DispatchWorkItem {
            self.doHide()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(Int(self.getRandomDouble(lower: 300, upper: 5000)*1000)), execute: self.pendingTask2!)
    }
    
    func doInvalidateTimer() {
        pendingTask2?.cancel()
        
        pendingTask = DispatchWorkItem {
            
        }
        
        DispatchQueue.main.async(execute: self.pendingTask!)
    }
    
    func getRandomDouble(lower: UInt32, upper: UInt32) -> Double {
        debugPrint("lower \(lower)")
        debugPrint("upper \(upper)")
        
        self.randomNum = arc4random_uniform(upper) + lower // range
        self.someInt = Int(self.randomNum!)
        self.someDouble = Double(self.someInt!) / 1000
        debugPrint("randomNum \(String(describing: self.randomNum))")
        debugPrint("someInt \(String(describing: self.someInt))")
        debugPrint("someDouble \(String(describing: self.someDouble))")
        debugPrint("milliseconds \(String(describing: Int(self.someDouble! * 1000)))")
        
        /*
        if (self.someDouble! >= upper) {
            self.someDouble! = upper
        }
        */
        
        return self.someDouble!
    }
    
    func doShow(direction: String, index: Int) {
        self.randomDouble = self.getRandomDouble(lower: 0, upper: 4)
        debugPrint("logooooooo mess: \(String(describing: self.randomDouble))")
        
        
        // populate loading view
        
        self.keyartView.image = UIImage(named: String(describing: self.channelKeyarts[self.fakeIndex]))
        self.callsignView.text = String(describing: self.channels[self.fakeIndex])
        self.logoView.image = UIImage(named: String(describing: self.channelLogos[self.fakeIndex]))
        self.titleView.text = String(describing: self.channelTitles[self.fakeIndex])
        self.metadataView.text = String(describing: self.channelMetadatas[self.fakeIndex])
        
        if (self.version == "motionA") {
            self.callsignView.alpha = 0.0
            
            // self.logoView.alpha = 0.0
            
            self.keyartView.alpha = 0.0
            
            self.titleView.alpha = 0.0
            self.loadingbarView.alpha = 0.0
            self.metadataView.alpha = 0.0
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseOut], animations: {
                self.loadingView.alpha = 1.0
                
                if (self.randomDouble == 0.0) {
                    self.callsignView.alpha = 1.0
                    self.logoView.alpha = 0.0
                } else {
                    self.callsignView.alpha = 0.0
                    self.logoView.alpha = 1.0
                }
            }, completion: { (finished: Bool) in
                self.doPopulate()
                
                if (index == 0) {
                    self.playerLayer?.player?.isMuted = false
                    self.playerLayer?.isHidden = false
                    
                    self.playerLayer2?.player?.isMuted = true
                    self.playerLayer2?.isHidden = true
                } else {
                    self.playerLayer?.player?.isMuted = true
                    self.playerLayer?.isHidden = true
                    
                    self.playerLayer2?.player?.isMuted = false
                    self.playerLayer2?.isHidden = false
                }
            })
        } else { // basic
            self.loadingView.alpha = 1.0
            self.callsignView.frame.origin.y = self.callsignViewFrameOriginYInitial
            self.logoView.frame.origin.y = self.logoViewFrameOriginYInitial
            
            if (self.randomDouble == 0.0) {
                self.callsignView.alpha = 1.0
                self.logoView.alpha = 0.0
                
                UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseOut], animations: {
                    self.callsignView.alpha = 0.0
                    self.logoView.alpha = 1.0
                }, completion: nil)
            } else {
                self.callsignView.alpha = 0.0
                self.logoView.alpha = 1.0
            }
            
            self.doPopulate()
        }
    }

    func doHide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.alpha = 0.0
            self.player.isMuted = false
        }, completion: nil)
    }
    
    func doPopulate() {
        self.titleView.alpha = 0.0
        self.loadingbarView.alpha = 0.0
        self.metadataView.alpha = 0.0
        self.keyartView.alpha = 0.0
        
        // self.loadingbarView.alpha = 1.0
        // self.loadingbarView.startAnimating()
        
        UIView.animate(withDuration: 0.3, delay: 0.3, options: [.curveEaseOut], animations: {
            self.titleView.alpha = 1.0
            self.metadataView.alpha = 1.0
            self.loadingbarView.alpha = 1.0
        }, completion: { (finished: Bool) in
            self.player.isMuted = true
        })
        
        UIView.animate(withDuration: 0.3, delay: self.getRandomDouble(lower: 300, upper: 3000), options: [.curveEaseOut], animations: {
            self.keyartView.alpha = 1.0
        }, completion: nil)
    }
    

    func doToggleVersion () {
        if (version == "motionA") {
            self.version = "simple"
            
        } else {
            self.version = "motionA"
        }
        
        self.versionView.text = self.version
    }
    
    func doLogo() {
        
    }

    
    override func remoteControlReceived(with event: UIEvent?) {
        // what
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        if(presses.first?.type == UIPress.PressType.upArrow) {
            // debugPrint("up arrow began")
            
            self.lastDirection = "up"
        } else if(presses.first?.type == UIPress.PressType.downArrow) {
            // debugPrint("down arrow began")
            
            self.lastDirection = "down"
        } else if(presses.first?.type == UIPress.PressType.leftArrow) {
            self.lastDirection = "left"
            
            debugPrint("fake index: \(String(describing: self.fakeIndex))")
            
            if (self.fakeIndex == 0) {
                self.fakeIndex = 1
            } else {
                self.fakeIndex = 0
            }
            
            doShow(direction: "left", index: self.fakeIndex)
        } else if(presses.first?.type == UIPress.PressType.rightArrow) {
            self.lastDirection = "right"
        }
        
        // Presses in progress - !ended, !cancelled, just invalidate it
        // self.doInvalidateTimer()
        
        // surfing timer
        // self.timerStart(sender: event!)
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        // Presses ended || cancelled, restart timer
        self.doRestartTimer()
        
        // surfing timer
        self.timerCancel(sender: event!)
    }
}
