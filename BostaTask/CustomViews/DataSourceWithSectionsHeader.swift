//
//  DataSourceWithSectionsHeader.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 23/04/2022.
//

import UIKit

protocol SectionProtocol: Hashable {
    var header: String { get }
}

class DataSourceWithSectionsHeader<section: SectionProtocol, items: Hashable>: UITableViewDiffableDataSource<section, items> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.snapshot().sectionIdentifiers[section]
        return section.header
    }
}
