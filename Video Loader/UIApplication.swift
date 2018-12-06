import UIKit

@objc(MyApplication)

class MyApplication: UIApplication {
    
    weak var myVC: ViewController?
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        // Ignore .Touches .Motion and .RemoteControl event simply everything else then .Presses
        if event!.type != .presses {
            super.sendEvent(event!)
            return
        }
        
        // Presses in progress - !ended, !cancelled, just invalidate it
        print("Invalidate auto lock timer")
        myVC?.doInvalidateTimer()
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        // Presses ended || cancelled, restart timer
        print("Restart auto lock timer")
        myVC?.doRestartTimer()
    }
}
