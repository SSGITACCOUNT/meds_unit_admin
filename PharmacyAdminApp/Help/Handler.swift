//
//  Handler.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-01-27.
//

import Foundation

import Foundation

public typealias ActionHandler = (_ status: Bool, _ message: String?) -> ()
public typealias CompletionHandlerWithData = (_ status: Bool, _ message: String?, _ data: Any?) -> ()
public typealias AlertActionHandler = (_ action: String) -> ()
public typealias LocationHandler = (_ latitude: Double, _ longitude: Double, _ address: String ) -> ()
public typealias HandelStatusType = (_ status: Bool, _ type: StatusType, _ data: Any?) -> ()
