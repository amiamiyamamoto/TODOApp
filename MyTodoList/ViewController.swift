//
//  ViewController.swift
//  MyTodoList
//
//  Created by s247 on 2017/11/20.
//  Copyright © 2017年 ami. All rights reserved.
//

import UIKit

//UITableViewDataSourceと、UITabBarDelegateの設定
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //ToDoを格納する変数を宣言
    var todoList = [MyTodo]()
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
                
                //MyTodoのインスタンスを作成する
                let myTodo = MyTodo()
                myTodo.todoTitle = textField.text!
                self.todoList.insert(myTodo, at: 0)
                
                
                
                //toDoリストの内容を配列に入れる
                //self.todoList.insert(textField.text!, at: 0)
                //テーブルに配列が追加されたことをテーブルに通知
                self.tableView.insertRows(at: [IndexPath(row: 0,section: 0)], with: UITableViewRowAnimation.right)
                let ud = UserDefaults.standard
                
                //ここから2017/12/18　Data型にシリアライズする
                let data = NSKeyedArchiver.archivedData(withRootObject: self.todoList)
                
                ud.set(data, forKey: "todoList")
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
        
        //行番号に合ったToDoの情報を取得
        let myTodo = todoList[indexPath.row]
        
        //CellのラベルにToDoのタイトルをセット
        cell.textLabel?.text = myTodo.todoTitle
        
        //Cellにチェックマークの情報をセット
        if myTodo.todoDone {
            //チェックあり
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        } else {
            //チェックなし
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        
        return cell
    }
    
    //セルをタップしたときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myTodo = todoList[indexPath.row]
        if myTodo.todoDone {
            myTodo.todoDone = false
        } else {
            myTodo.todoDone = true
        }
        
        //Cellの状態を変更
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        
        //データ保存。Data型にシリアライズする
        let data:Data = NSKeyedArchiver.archivedData(withRootObject: todoList)
        
        //userDefaultsに保存
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "todoList")
        userDefaults.synchronize()
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //保存しているToDoの読み込み処理
        let ud = UserDefaults.standard
        //if let stredTodoList = ud.array(forKey: "todoList") as? [String]{
        if let stredTodoList = ud.object(forKey: "todoList") as? Data{
            //MyTodo型にダウンキャストする。ダウンキャストするとオプショナル型で返ってくる
            if let unarchiveTodoList =  NSKeyedUnarchiver.unarchiveObject(with: stredTodoList) as? [MyTodo] {
                todoList.append(contentsOf: unarchiveTodoList)
            }

//            todoList.append(contentsOf: stredTodoList)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Cellが編集可能かどうか返却する
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Cellを削除した時の処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //削除可能かどうか
        if editingStyle == UITableViewCellEditingStyle.delete {
            //TODOリストから削除
            print("delete")

            todoList.remove(at: indexPath.row)
            
            //Cellを削除
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            
            //deta型にシリアライズ
            let data:Data = NSKeyedArchiver.archivedData(withRootObject: todoList)
            
            //userDefaultに保存
            let userDefault = UserDefaults.standard
            userDefault.set(data, forKey: "todoList")
            userDefault.synchronize()
        }
    }
}


