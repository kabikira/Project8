//
//  ViewController.swift
//  Project8
//
//  Created by koala panda on 2023/02/04.
//

import UIKit

class ViewController: UIViewController {
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    
    // 正解した回数をカウント
    var correctAnswersCount = 0
    
    //メインビューを白くて大きな空間として作成します。これは、UIViewの新しいインスタンスを作成して、それに白い背景色を与え、それをビューコントローラのviewプロパティに割り当てるだけです。
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        // 手がかりと答えのラベルを追加
        cluesLabel = UILabel()
        // ビューの自動サイズ変更マスクが自動レイアウト制約に変換されるかどうかを決定するブール値。
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        // numberOfLines は整数値で、テキストが何行にわたって折り返されるかを設定
        cluesLabel.numberOfLines = 0
        // 優先度　縦の余白の出来にくさ
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.numberOfLines = 0
        answersLabel.textAlignment = .right
        // 優先度　縦の余白の出来にくさ
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answersLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        // Buttonをグレーの線で囲む
        submit.layer.borderWidth = 1
        submit.layer.borderColor = UIColor.lightGray.cgColor
        
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        // Buttonをグレーの線で囲む
        clear.layer.borderWidth = 1
        clear.layer.borderColor = UIColor.lightGray.cgColor
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        //isActive = trueを複数回設定するのではなく NSLayoutConstraint.activate()メソッドを使用して制約を有効化する、制約の配列を受け取ります。
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            // 手がかりラベルの上部をスコアラベルの下部に固定する
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            // 手がかりラベルの先端をレイアウトの余白の先端に固定し、100を加えてスペースを確保します。
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            // 手がかりラベルをレイアウトマージンの幅から100を引いた60%にする
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            // また、回答ラベルの上部とスコアラベルの下部をピンで固定します。
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            // 回答ラベルをレイアウトマージンの末尾から100引いた位置に貼り付けます。
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            // 回答ラベルが100を引いた40%のスペースを占めるようにする。
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            // 答えのラベルと手がかりのラベルの高さを一致させる
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            // textFieldのオートレイアウト
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            // Buttonのオートレイアウト
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant:  -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
            
            
        ])
        //　20個のボタン作成
        let width = 150
        let height = 80
        
        for row in 0..<4 {
            for col in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                // Buttonをグレーの線で囲む
                letterButton.layer.borderWidth = 1
                letterButton.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        //        cluesLabel.backgroundColor = .red
        //        answersLabel.backgroundColor = .blue
        //        buttonsView.backgroundColor = .green
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
        
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
        
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }
        
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()
            
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            correctAnswersCount += 1
            
            if correctAnswersCount == 7 {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        } else {
            let ac = UIAlertController(title: "Wrong!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Done", style: .default))
            present(ac, animated: true)
            score -= 1
        }
    }
    
    func levelUp(action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        
        loadLevel()
        
        for btn in letterButtons {
            btn.isHidden = false
        }
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        
        for btn in activatedButtons {
            btn.isHidden = false
        }
        
        activatedButtons.removeAll()
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let levelFileURL = Bundle.main.url(forResource: "level\(self.level)", withExtension: "txt") {
                if let levelContents = try? String(contentsOf: levelFileURL) {
                    var lines = levelContents.components(separatedBy: "\n")
                    lines.shuffle()
                    
                    
                    for (index, line) in lines.enumerated() {
                        let parts = line.components(separatedBy: ": ")
                        let answer = parts[0]
                        let clue = parts[1]
                        
                        
                        clueString += "\(index + 1). \(clue)\n"
                        
                        let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                        solutionString += "\(solutionWord.count) letters\n"
                        self.solutions.append(solutionWord)
                        
                        let bits = answer.components(separatedBy: "|")
                        letterBits += bits
                    }
                }
            }
            DispatchQueue.main.async {
                self.cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
                self.answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
                
                letterBits.shuffle()
                
                if letterBits.count == self.letterButtons.count {
                    for i in 0 ..< self.letterButtons.count {
                        
                        self.letterButtons[i].setTitle(letterBits[i], for: .normal)
                    }
                }
            }
        }
        
    }
    
}

