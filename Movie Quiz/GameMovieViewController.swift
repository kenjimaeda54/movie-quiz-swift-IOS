//
//  ViewController.swift
//  Movie Quiz
//
//  Created by kenjimaeda on 30/08/22.
//

import UIKit
import AVFoundation

class GameMovieViewController: UIViewController {
	
	@IBOutlet weak var viSoundBar: UIView!
	@IBOutlet weak var sliMusic: UISlider!
	@IBOutlet weak var imgSound: UIImageView!
	@IBOutlet weak var vTimer: UIView!
	@IBOutlet var btnNamovie: [UIButton]!
	
	var quizManager = QuizManager()
	var player: AVAudioPlayer?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		quizManager = QuizManager()
		getNewQuiz()
		startTimer()
	}
	
	func getNewQuiz() {
		let (_,option) = quizManager.generatorRandomQuiz()
		for i in 0...3 {
			btnNamovie[i].setTitle(option[i].name, for: .normal)
		}
		playGame()
	}
	
	func startTimer() {
		//vai ficar do tamanho da screen
		//para animacao dar certo nao pode haver constraint por isso foi usado
		//frame
		vTimer.frame = view.frame
		UIView.animate(withDuration: 60.0, delay: 0.0, options: .curveLinear) {
			self.vTimer.frame.size.width = 0
			//para ficar no centro
			self.vTimer.frame.origin.x = self.view.center.x
		} completion: { (sucess) in
			self.gameOver()
		}
	}
	
	@IBAction func playGame() {
		let round = quizManager.round
		imgSound.image = UIImage(named: "movieSound")
		do {
			if let urlSound = Bundle.main.url(forResource: "quote\(round!.quiz.number)", withExtension: "mp3") {
				player = try AVAudioPlayer(contentsOf: urlSound)
				player?.volume = 1
				player?.delegate = self
				player?.play()
			}
			
		}catch {
			print(error.localizedDescription )
		}
		
	}
	
	func gameOver() {
		performSegue(withIdentifier: "congratulationsSegue", sender: nil)
		player?.stop()
		
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

//MARK: - AVAudioPlayerDelegate
extension GameMovieViewController:AVAudioPlayerDelegate  {
	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
		imgSound.image = UIImage(named: "movieSoundPause")
	}
}
