# Movie quiz
Aplicativo para descobrir qual música está tocando no fundo, de acordo as opções de filmes que aparecem

## Motivação
Praticar novamente o uso das classes de AVFoundation e manipular arquivos em bundle


## Feature
- Para comparar dicionários usamos o protocolo Equatable
- Normalmente quando lidamos com array de dicionário o Swift ira acusar erro no método containes, para evitar isso pode aproveitar o uso do protocolo Equatable

```swift

extension QuizOption: Equatable {
	static func==(l:QuizOption,r:QuizOption) ->Bool{
		return l.name == r.name
	}
}

```

## 
- Para gerar números aleatórios usei o recurso do Set, vantagem de usar um set para essas ocasiões e que números não oira repetir e não sera ordenado
- Por isso consigo abaixo gerar 4 números aleatórios sem entrar em loop inifito 
- Para o retorno de duas propriedades em uma função pode usar do recurso de tupla, neste caso além de usar tuplas utilizei recurso de type alias,assim posso apenas chamar o apelido da tupla



```swift
typealias Round = (quiz: Quiz,option: [QuizOption])

//=====
	mutating	func generatorRandomQuiz() -> Round  {
		let index = Int.random(in: 0...4)
		let quiz = quizes[index]
		var indexQuizOption: Set<Int> = [index]
		while indexQuizOption.count < 4 {
			let index = Int.random(in: 0...4)
			indexQuizOption.insert(index)
		}
		let options = indexQuizOption.map({quizOptions[$0]})
		round = Round(quiz,options)
		return round!
	}
	
```

##
- Coloquei em prática o uso de genéricos, assim a função  se torna flexível aceitando qualquer tipo, desde que seja conforme o contrato
- Nesse caso precisava reaproveitar a função que faz o uso do decoder 
- Repara que minha função genérica serve para [Quiz] e [QuizOption]


```swift


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



//funcao generica
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
	

```


##
- Pratiquei novamente animação, neste caso era uma view por trás
- Para animar esta view não declarei nenhuma constraint, seu tamanho foi determinado no código
- View animada tem o mesmo tamanho que a tela pelo view.frame
- Para manter ela sempre no centro, o seu frame.origin.x e o centro da tela pelo center.x



```swift
	func startTimer() {
		vTimer.frame = view.frame
		UIView.animate(withDuration: 30.0, delay: 0.0, options: .curveLinear) {
			self.vTimer.frame.size.width = 0
			//para ficar no centro
			self.vTimer.frame.origin.x = self.view.center.x
		} completion: { (sucess) in
			self.gameOver()
		}
	}

```

##
- Utilizei um slider , ele progredia conforme a música de fundo, neste caso utilizei um observador do AVPlayer
- AVPlayer também excelente para stream via nuvem
- Caso deseja stream via nuvem, precisa apenas subistuir a url para uma URl(string)
- Nome do observador e addPeriodicTimeObserver


```swift
	func startBackgroundMusic(){
		if let url = Bundle.main.url(forResource: "MarchaImperial", withExtension: "mp3"){
			playerItem = AVPlayerItem(url: url)
			playerBackground = AVPlayer(playerItem: playerItem)
			playerBackground?.volume = 0.2
			playerBackground?.play()
			playerBackground?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: nil, using: { [self](timer) in
				let percent = timer.seconds / playerItem.duration.seconds
				sliMusic.setValue(Float(percent), animated: true)
			})
		}
		
	}
```


##
- Para controlar o player de música com AVPlayer podemos usar do método timeControlStatus

```swift
 @IBAction func playPauseSound(_ sender: UIButton) {
		if playerBackground?.timeControlStatus == .paused {
			playerBackground?.play()
			sender.setImage(UIImage(named: "pause"), for: .normal)
			
		}else {
			playerBackground?.pause()
			sender.setImage(UIImage(named: "play"), for: .normal)
		}
		
	}

```










