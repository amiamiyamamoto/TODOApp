//
//  MyTodo.swift
//  MyTodoList
//
//  Created by s247 on 2017/12/22.
//  Copyright © 2017年 ami. All rights reserved.
//

import Foundation

//独自クラスをシリアライズする際にはNSObjectを継承し
//NSCodingプロトコルに準拠する必要がある
class MyTodo: NSObject, NSCoding{
    //ToDoのタイトル
    var todoTitle:String?
    //ToDoを完了したかどうかを表すフラグ
    var todoDone:Bool = false
    
    override init() {
    }
    
    //NSCodingでプロトコルに宣言されているシリアライズ処理。エンコード処理とも
    func encode(with aCoder: NSCoder) {
        aCoder.encode(todoTitle, forKey: "todoTitle")
        aCoder.encode(todoDone, forKey: "todoDone")
    }
    
    //NSCodingでプロトコルに宣言されているデリシリアライズ処理。デコード処理とも
    required init?(coder aDecoder: NSCoder) {
        todoTitle = aDecoder.decodeObject(forKey:"todoTitle") as? String
        todoDone  = aDecoder.decodeBool(forKey: "todoDone")
    }
    
}
