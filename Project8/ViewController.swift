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
        view.addSubview(cluesLabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.numberOfLines = 0
        answersLabel.textAlignment = .right
        view.addSubview(answersLabel)
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
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor)

            // more constraints to be added here!
        ])
        cluesLabel.backgroundColor = .red
        answersLabel.backgroundColor = .blue
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //メインビューを白くて大きな空間として作成します。これは、UIViewの新しいインスタンスを作成して、それに白い背景色を与え、それをビューコントローラのviewプロパティに割り当てるだけです。
    


}
