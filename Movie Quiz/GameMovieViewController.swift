//
//  ViewController.swift
//  Movie Quiz
//
//  Created by kenjimaeda on 30/08/22.
//

import UIKit

class GameMovieViewController: UIViewController {

	@IBOutlet weak var viSoundBar: UIView!
	@IBOutlet weak var sliMusic: UISlider!
	@IBOutlet weak var imgSound: UIImageView!
	@IBOutlet var btnNamovie: [UIButton]!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func playPauseSound(_ sender: UIButton) {
	}
	
	
	@IBAction func changeMusicStatus(_ sender: UIButton) {
	}
	
	@IBAction func showHideSound(_ sender: UIButton) {
	}
	
	
	@IBAction func changeMusicTime(_ sender: UISlider) {
	}
	
}

