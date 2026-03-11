// 
//  HomeModel.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 11/03/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

struct HomeModel: Codable, Sendable {
    let sections: [SectionModel]
    let pagination: PaginationModel
}
