//
//  oneselfDiceViewController.swift
//  dicePlay
//
//  Created by 郭家宇 on 2023/8/9.
//

import UIKit

class oneselfDiceViewController: UIViewController {
    
    @IBOutlet var magnificationSegmentedControl: UISegmentedControl!
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var palyButton: UIButton!
    @IBOutlet var diceImageView: [UIImageView]!
    @IBOutlet var bigsmallSegmentedControl: UISegmentedControl!
    
    @IBOutlet var betSegmentControl: UISegmentedControl!
    var balance:Int = 3000
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func play(){
        var betmoney :Int
        switch betSegmentControl.selectedSegmentIndex{
        case 0:
            betmoney = 100
        case 1:
            betmoney = 500
        case 3:
            betmoney = balance
        default:
            betmoney = 0
        }
        switch magnificationSegmentedControl.selectedSegmentIndex{
        case 0:
            betmoney *= 2
            print(betmoney)
        case 1:
            betmoney *= 3
            print(betmoney)
        case 2:
            betmoney *= 4
            print(betmoney)
        default:
            betmoney = 0
        }
            var title: String = ""
            var message:String = ""
            
            if betmoney > balance{
                title = "你的餘額不夠"
                message = "你還差\(betmoney - balance)"
            }else {
                var sum = 0
                for diceImage in diceImageView{
                    let number = Int.random(in: 1...6)
                    sum += number
                    diceImage.image = UIImage(systemName: "die.face.\(number)")
                }
                
                if (bigsmallSegmentedControl.selectedSegmentIndex == 1 && sum < 10)||(bigsmallSegmentedControl.selectedSegmentIndex == 0 && sum >= 10 ){
                    balance += Int(betmoney * 2)
                    title = "Win"
                    message = "總和是\(sum)"
                }else{
                    balance -= betmoney
                    if balance == 0 {
                        title = "GameOver"
                        message = "餘額不足"
                        palyButton.setTitle("restart", for: .normal)
                    }else{
                        title = "Lose"
                        message = "輸了 $\(betmoney)"
                    }
                }
                balanceLabel.text = "Your balance: $\(balance)"
            }
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            controller.addAction(okAction)
            if balance >= betmoney {
                let replayAction = UIAlertAction(title: "PlayAgain", style: .default){
                    _ in self.play()
                }
                controller.addAction(replayAction)
            }
            present(controller,animated: true)
            
        }
        func replay(){
            palyButton.setTitle("Play", for: .normal)
            balance = 3000
            balanceLabel.text = "Your balance: $\(balance)"
            betSegmentControl.selectedSegmentIndex = 0
            bigsmallSegmentedControl.selectedSegmentIndex = 0
            for diceImage in diceImageView {
                diceImage.image = UIImage(systemName: "die.face.1")
            }
        }
        
        @IBAction func playButton(_ sender: Any) {
            if palyButton.currentTitle == "Play"{
                play()
            }else{
                replay()
            }
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
