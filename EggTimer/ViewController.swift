import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var titleLabel: UILabel!
    let eggTimes = ["Soft": 300, "Medium": 480, "Hard": 720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress : Float = Float(secondsPassed)/Float(totalTime)
            progressBar.progress = percentageProgress
        } else {
            timer.invalidate()
            titleLabel.text = "Done!"
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
}
