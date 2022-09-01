//
//  QuizManager.swift
//  Movie Quiz
//
//  Created by kenjimaeda on 01/09/22.
//

import Foundation


struct QuizManager {
	
	var quizes: [Quiz] = []
	var quizOptions: [QuizOption] = []
	var score = 0
	
	
	init() {
		
		if  let fileUrlQuizes = Bundle.main
			.url(forResource: "quizes", withExtension: "json") {
			
			do {
				let data = try Data(contentsOf: fileUrlQuizes)
				if let jsonData = jsonParse(data)  as [Quiz]? {
					quizes = jsonData
				}
				
			}catch {
				print(error.localizedDescription)
			}
			
		}
		if  let fileUrlQuizOptions = Bundle.main
			.url(forResource: "options", withExtension: "json") {
			
			do {
				let data = try Data(contentsOf: fileUrlQuizOptions)
				if let jsonData = jsonParse(data)  as [QuizOption]? {
					quizOptions = jsonData
				}
				
			}catch {
				print(error.localizedDescription)
			}
			
		}
		
		
	}
	
	
	func jsonParse<T:Decodable>(_ data: Data) -> [T]?  {
		let jsonParser = JSONDecoder()
		do {
			let json = try jsonParser.decode([T].self, from: data )
			return json
		}catch {
			print(error)
			return nil
		}
	}
	
	
}
