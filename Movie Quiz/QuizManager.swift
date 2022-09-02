//
//  QuizManager.swift
//  Movie Quiz
//
//  Created by kenjimaeda on 01/09/22.
//

import Foundation

typealias Round = (quiz: Quiz,option: [QuizOption])

struct QuizManager {
	
	var quizes: [Quiz] = []
	var quizOptions: [QuizOption] = []
	var score = 0
	var round: Round?
	
	init() {
		
		if let urlQuizes = Bundle.main.url(forResource: "quizes", withExtension: "json"){
			do {
				let data = try Data(contentsOf: urlQuizes)
				if let jsonQuiz = jsonParse(data) as [Quiz]? {
					quizes = jsonQuiz
				}
				
			}catch {
				print(error.localizedDescription)
			}
		}
		
		
		if let urlQuizOptions = Bundle.main.url(forResource: "quizes", withExtension: "json"){
			
			do {
				let data = try Data(contentsOf: urlQuizOptions)
				if let jsonQuizOption = jsonParse(data) as [QuizOption]? {
					quizOptions = jsonQuizOption
				}
				
			}catch {
				print(error.localizedDescription)
				
			}
			
		}
	}
	
	
	func jsonParse<T: Codable>(_ data: Data) -> [T]? {
		let decoder = JSONDecoder()
		do {
			let jsonData = try decoder.decode([T].self, from: data)
			return jsonData
		}catch {
			print(error.localizedDescription)
			return nil
		}
	}
	
	
	mutating	func generatorRandomQuiz() -> Round  {
		let index = Int.random(in: 0...4)
		let quiz = quizes[index]
		//vantagem de usar set que nao ira repetir e alem de tudo
		//nao sera ordenado assim nosso index pode estar em qualquer lugar
		var indexQuizOption: Set<Int> = [index]
		while indexQuizOption.count < 4 {
			//nao tem como se repetir porque e um set
			let index = Int.random(in: 0...4)
			indexQuizOption.insert(index)
		}
		let options = indexQuizOption.map({quizOptions[$0]})
		round = Round(quiz,options)
		return round!
	}
	
	
	mutating func  checkAnswer(_ name: String?) {
		if name == round?.quiz.name {
			score += 1
			print("acertou")
		}
		
	}
	
}
