//
//  mainViewController.swift
//  dicePlay
//
//  Created by 郭家宇 on 2023/8/9.
//

import UIKit

class mainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func oneselfButton(_ sender: UIButton) {
        let identifier = sender.tag == 0 ? "oneselfShow" : "twoselfShow"
            performSegue(withIdentifier: identifier, sender: nil)
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
