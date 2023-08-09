//
//  diceViewController.swift
//  dicePlay
//
//  Created by 郭家宇 on 2023/8/9.
//

import UIKit

class diceViewController: UIViewController {

    @IBOutlet var player1Label: UILabel!
    @IBOutlet var Player2Label: UILabel!
    @IBOutlet var player1imageview: [UIImageView]!
    @IBOutlet var player2imageview: [UIImageView]!
    @IBOutlet var bigandsmallSegmentedControl: UISegmentedControl!
    @IBOutlet var playButton: UIButton!
    var player1balance = 3000
    var player2balance = 3000
    
    let betmoney = 500
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func play(){
        var title : String = ""
        var  message:String = ""
        var sum = 0
        var sum1 = 0
        for player1ImageView in player1imageview {
            let index = Int.random(in: 1...6)
            player1ImageView.image = UIImage(systemName: "die.face.\(index)")
            sum += index
            print("sum: \(sum)")
        }
        
        for player2ImageView in player2imageview{
            let index2 = Int.random(in: 1...6)
            player2ImageView.image = UIImage(systemName: "die.face.\(index2)")
            sum1 += index2
            print("sum1: \(sum1)")
        }
        
        if  (bigandsmallSegmentedControl.selectedSegmentIndex == 0 && sum > sum1) ||
                (bigandsmallSegmentedControl.selectedSegmentIndex == 1 && sum < sum1) {
                player2balance -= 500
                Player2Label.text = "Player2 Balance: \(player2balance)"
            } else if sum1 == sum {
                title = "平手"
                message = "本局不扣額"
                let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "ok", style: .default)
                controller.addAction(OKAction)
                present(controller, animated: true)
            } else {
                player1balance -= 500
                player1Label.text = "Player1 Balance: \(player1balance)"
            }
        checkmoney()
        
    }
    func checkmoney(){
        var title : String = ""
        var  message:String = ""
        if player1balance == 0 || player1balance < 500{
            title = "Player1 Lose"
            message = "Player1 餘額不足,\nPlayer2獲勝"
            playButton.setTitle("replay", for: .normal)
            showResultAlert(title: title, message: message)
           
        }else if  player2balance == 0 || player2balance < 500{
            title = "Player2 Lose"
            message = "Player2 餘額不足,\nPlayer1獲勝"
            playButton.setTitle("replay", for: .normal)
            showResultAlert(title: title, message: message)
           
        }

    }
    func replay(){
        player1Label.text = "Player1 Balance: $3000"
        Player2Label.text = "Player2 Balance: $3000"
        player1balance = 3000
        player2balance = 3000
        bigandsmallSegmentedControl.selectedSegmentIndex = 0
        for player1ImageView in player1imageview {
            player1ImageView.image = UIImage(systemName: "die.face.1")
        }
        for player2ImageView in player2imageview{
            player2ImageView.image = UIImage(systemName: "die.face.1")
        }
        playButton.setTitle("Play", for: .normal)
    }

    @IBAction func playButtonTap(_ sender: Any) {
        if playButton.currentTitle == "Play"{
            play()
        }else{
            replay()
        }
    }
    func showResultAlert(title: String, message: String) {
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let replayAction = UIAlertAction(title: "重玩", style: .default) { _ in
                self.replay()
            }
            controller.addAction(replayAction)
            present(controller, animated: true)
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
