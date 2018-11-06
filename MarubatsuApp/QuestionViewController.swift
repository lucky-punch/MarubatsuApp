//
//  QuestionViewController.swift
//  MarubatsuApp
//
//  Created by nowall on 2018/11/03.
//  Copyright © 2018 sparta-asano.jp. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITextFieldDelegate{

    
    @IBOutlet weak var questionField: UITextField!
    
    
    
    @IBOutlet weak var marubatsuControl: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    

    @IBAction func tapBackToTopButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func tapSaveButton(_ sender: Any) {
        var answer:Bool = true
        if questionField.text != "" {
            //questionFieldが空じゃなかったときの処理
            if marubatsuControl.selectedSegmentIndex == 0 {
                answer = false
            } else {
                answer = true
            }
            let userDefaults = UserDefaults.standard
            if userDefaults.object(forKey: "questions") != nil {
                var questions = userDefaults.object(forKey: "questions") as! [[String:Any]]
                questions.append(
                    [
                        "question" : questionField.text,
                        "answer" : answer
                    ]
                )
                //"questions"というキーでquestionsという配列を保存
                userDefaults.set(questions, forKey:"questions")
                showAlert(message: "問題が保存されました")
                questionField.text = ""
            } else {
                var questions:[[String:Any]] = []
                questions.append(
                    [
                        "question" : questionField.text,
                        "answer" : answer
                    ]
                )
                //"questions"というキーでquestionsという配列を保存
                userDefaults.set(questions, forKey:"questions")
                showAlert(message: "問題が保存されました")
                questionField.text = ""
            }
            
        } else {
            //何も文字が入力されていないとき
            showAlert(message: "問題文が入力されてませんよ")
        }
        
    }
    
    
    
    @IBAction func tapAllDeleteButton(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "questions")
        /*    問題と解答を削除したので、キーが"questions"のオブジェクトの値がnilになる
         *  -> 読み込まれたときのエラーを回避するために値に空の配列を入れておく
         */
//        userDefaults.set([], forKey: "questions")
        showAlert(message: "問題をすべて削除しました。")
    }
    
    
    // アラートを表示する関数
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
