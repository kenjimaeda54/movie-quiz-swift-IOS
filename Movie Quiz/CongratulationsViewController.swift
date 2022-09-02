//
//  CongratulationsViewController.swift
//  Movie Quiz
//
//  Created by kenjimaeda on 30/08/22.
//

import UIKit

class CongratulationsViewController: UIViewController {

	@IBOutlet weak var labScore: UILabel!
	var score = 0
	 
    override func viewDidLoad() {
        super.viewDidLoad()
			labScore.text = "\(score)"
		}
    

	@IBAction func playAgaim(_ sender: UIButton) {
		dismiss(animated: true)
	}
	

}
