//
//  ViewController.swift
//  MyTodoList
//
//  Created by s247 on 2017/11/20.
//  Copyright © 2017年 ami. All rights reserved.
//

import UIKit

//UITableViewDataSourceと、UITabBarDelegateの設定
class ViewController: UIViewController, UITableViewDataSource, UITabBarDelegate {
    
    
    //ToDoを格納する変数を宣言
    var todoList = [String]()
    //テーブルを格納した変数を宣言
    @IBOutlet weak var tableView: UITableView!

    //+ボタンを押された時に実行
    @IBAction func tupAddButton(_ sender: Any) {
        //アラートダイアログを生成
        let alertContoroller = UIAlertController(title: "TODO追加", message: "TODOを入力してください", preferredStyle: UIAlertControllerStyle.alert)
        
        //テキストフィールドを追加する
        alertContoroller.addTextField(configurationHandler: nil)
        
        //OKボタンを作成、追加
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            //OKボタンが押されたときの処理
            if let textField = alertContoroller.textFields?.first {
                //toDoリストの内容を配列に入れる
                self.todoList.insert(textField.text!, at: 0)
                //テーブルに配列が追加されたことをテーブルに通知
                self.tableView.insertRows(at: [IndexPath(row: 0,section: 0)], with: UITableViewRowAnimation.right)
                let ud = UserDefaults.standard
                ud.setValue(self.todoList, forKey: "todoList")
                ud.synchronize()
            }
        }
        //OKボタン追加
        alertContoroller.addAction(okAction)
        
        //キャンセルボタン追加
        let cancelButton = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alertContoroller.addAction(cancelButton)
        
        //アラートダイアログを表示
        present(alertContoroller, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //storyBoadで指定したidentify　todoCell識別子を利用して再利用可能なセルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        //行番号に合ったToDoのタイトルを取得
        let todoTitle = todoList[indexPath.row]
        
        //CellのラベルにToDoのタイトルをセット
        cell.textLabel?.text = todoTitle
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //保存しているToDoの読み込み処理
        let ud = UserDefaults.standard
        if let stredTodoList = ud.array(forKey: "todoList") as? [String]{
            todoList.append(contentsOf: stredTodoList)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

