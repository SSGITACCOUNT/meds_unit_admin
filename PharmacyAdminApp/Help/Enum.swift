//
//  Enum.swift
//  PharmacyAdminApp
//
//  Created by Shashee on 2024-01-26.
//
import UIKit

enum Storyboard: String {
    case Auth
    case Main
    case Admin
    case Home
    case RoadTrip
    case Order
    case Setting
    case Earning
    case Location
}

public enum StatusType: String {
    case notAcceptable = "PENDING"
    case readyToPickup = "READYTOPICKUP"
    case completed = "COMPLETED"
    case cancle = "CANCLED"
}
