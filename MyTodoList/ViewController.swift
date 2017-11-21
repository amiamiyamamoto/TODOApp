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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

