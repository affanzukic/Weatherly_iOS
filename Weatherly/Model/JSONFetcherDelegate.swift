//
//  JSONFetcherDelegate.swift
//  Weatherly
//
//  Created by Affan Zukić on 2020-05-06.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import Foundation

protocol JSONFetcherDelegate
{
    func didFinishFetching(_ sender:JSONFetcher)
}
