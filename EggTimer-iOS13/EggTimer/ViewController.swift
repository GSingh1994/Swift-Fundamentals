import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    let eggTimes = [ "Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    @IBOutlet weak var eggLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        progressBar.progress = 0
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0
        secondsPassed = 0
        let hardness = sender.currentTitle
        
        totalTime = eggTimes[hardness!]!
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            
            if self.secondsPassed < self.totalTime {
                self.eggLabel.text = hardness
                self.secondsPassed += 1
                let percentageProgress = Float(self.secondsPassed) / Float(self.totalTime)
                self.progressBar.progress = percentageProgress
            } else {
                timer.invalidate()
                self.eggLabel.text = "DONE!"
                self.playSound()
            }
            
        }
    }
}
