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
	var playerBackground: AVPlayer?
	var playerItem: AVPlayerItem!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		startBackgroundMusic()
		viSoundBar.isHidden = true
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		quizManager = QuizManager()
		getNewQuiz()
		startTimer()
		
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "congratulationsSegue"{
			let vc = segue.destination as! CongratulationsViewController
			vc.score = quizManager.score
		}
	}
	
	func startBackgroundMusic(){
		if let url = Bundle.main.url(forResource: "MarchaImperial", withExtension: "mp3"){
			playerItem = AVPlayerItem(url: url)
			playerBackground = AVPlayer(playerItem: playerItem)
			playerBackground?.volume = 0.2
			playerBackground?.play()
			//adicionar um obersador para manipular o slider de forma animada
			playerBackground?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: nil, using: { [self](timer) in
				let percent = timer.seconds / playerItem.duration.seconds
				sliMusic.setValue(Float(percent), animated: true)
			})
		}
		
	}
	
	
	func startTimer() {
		//vai ficar do tamanho da screen
		//para animacao dar certo nao pode haver constraint por isso foi usado
		//frame
		vTimer.frame = view.frame
		UIView.animate(withDuration: 30.0, delay: 0.0, options: .curveLinear) {
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
	
	func getNewQuiz() {
		let (_,option) = quizManager.generatorRandomQuiz()
		for i in 0...3 {
			btnNamovie[i].setTitle(option[i].name, for: .normal)
		}
		playGame()
	}
	
	
	func gameOver() {
		performSegue(withIdentifier: "congratulationsSegue", sender: nil)
		player?.stop()
		
	}
	
	@IBAction func playPauseSound(_ sender: UIButton) {
		if playerBackground?.timeControlStatus == .paused {
			playerBackground?.play()
			sender.setImage(UIImage(named: "pause"), for: .normal)
			
		}else {
			playerBackground?.pause()
			sender.setImage(UIImage(named: "play"), for: .normal)
		}
		
	}
	
	
	@IBAction func changeMusicStatus(_ sender: UIButton) {
		quizManager.checkAnswer(sender.title(for: .normal))
		getNewQuiz()
	}
	
	@IBAction func showHideSound(_ sender: UIButton) {
		viSoundBar.isHidden = !viSoundBar.isHidden
	}
	
	
	@IBAction func changeMusicTime(_ sender: UISlider) {
		//sender value traz de 0 a 1,por isso multiplicado pelo tempo em seconds
		playerBackground?.seek(to: CMTimeMakeWithSeconds(Double(sender.value) * playerItem.duration.seconds, preferredTimescale: 1))
		
	}
	
}

//MARK: - AVAudioPlayerDelegate
extension GameMovieViewController:AVAudioPlayerDelegate  {
	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
		imgSound.image = UIImage(named: "movieSoundPause")
	}
}
