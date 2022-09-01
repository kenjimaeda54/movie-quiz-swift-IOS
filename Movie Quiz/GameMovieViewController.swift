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
	
	var quizManager = QuizManager()
	
	override func viewDidLoad() {
		super.viewDidLoad()

	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		quizManager = QuizManager()
		getNewQuiz()
	}
	
	func getNewQuiz() {
		let (quiz,option) = quizManager.generatorRandomQuiz()
		print(quiz)
		for i in 0...3 {
			btnNamovie[i].setTitle(option[i].name, for: .normal)
		}
	}
	
	@IBAction func playPauseSound(_ sender: UIButton) {
	}
	
	
	@IBAction func changeMusicStatus(_ sender: UIButton) {
		quizManager.checkAnswer(sender.title(for: .normal))
		getNewQuiz()
	}
	
	@IBAction func showHideSound(_ sender: UIButton) {
	}
	
	
	@IBAction func changeMusicTime(_ sender: UISlider) {
	}
	
}

