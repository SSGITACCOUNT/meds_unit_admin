//
//  Enum.swift
//  PharmacyAdminApp
//
//  Created by Sashikala Sewwandi on 2024-01-19.
//

import UIKit

enum Storyboard: String {
    case Auth
    case Main
    case Admin
    case Home
    case RoadTrip
    case Order
    case Product
    case Setting
    case Earning
    case Location
}

enum AppEnvirement {
    case Live
    case Demo
    case Development
}

public enum ValidateError: Error {
    case invalidData(String)
}

public enum ErrorResponse : Error {
    case error(Int, Data?, Error)
}

enum DriverType: String {
    case Taxi = "TAXI"
    case Delivery = "DELIVERY"
}

enum TripNotificationType: String {
    case taxi = "TAXI"
    case order = "ORDER"
}

enum TripNotificationStatusType: String {
    case taxi = "TAXI"
    case order = "ORDER"
}

enum OngoingTripStatusType: String {
    case cancel = "CANCELLED"
}

enum OngoingTripType: String {
    case taxi = "TAXI"
    case delivery = "DELIVERY"
    case roadTrip = "ROAD_TRIP"
}

enum DriverStatusType: String {
    case online = "ONLINE"
    case offline = "OFFLINE"
}

enum BookingStatusType: String {
    case pending = "PENDING"
    case preparing = "PREPARING"
    case ready = "READY"
    case complete = "COMPLETE"
    case cancel = "CANCELLED"
}

enum UploadType: String {
    case camera = "Camera"
    case library = "Photo Library"
}

enum AddVehicleListType {
    case manufactureYear
    case brand
    case model
    case fualType
    case insurance
}

enum ContactPhoneType {
    case aboutUs
    case support
}
enum KeyManagerEnum: String {
    case appLanguage = "CURRENT_LANGUAGE"
    case isAppLanguageRTL = "NSForceRightToLeftWritingDirection"
    case accessToken = "ACCESS_TOKEN"
    case refreshToken = "REFRESH_TOKEN"
    case userId = "USER_ID"
    case isNotInitialLaunch = "IS_Not_INITIAL_LAUNCH"
    case fcmToken = "FCM_TOKEN"
    
    case backgroundTime = "BACKGROUND_TIME"
    
    case ongoingTrip = "ONGOING_TRIP"
    case ongoingTripType = "ONGOING_TRIP_TYPE"
    
    case isTaxiDriverType = "IS_TAXI_DRIVER_TYPE"
    case isOnlineDriverStatus = "IS_ONLINE_DRIVER_STATUS"
    
    //Road trip
    case isWaitingEnableTrip = "IS_WAITING_ENABLE_TRIP"
    case isWaitingTrip = "IS_WAITING_TRIP"
    case waitingTimeTrip = "WAITING_TIME_TRIP"
    case totalTimeTrip = "TOTAL_TIME_TRIP"
}

enum FirestoreCollections:String{
    case users = "users"
    case stores = "stores"
    case address = "address"
    case product = "product"
    case orders = "orders"
}
enum FirestoreSecondCollections:String{
    case uderAddress = "GuideAddress"
}

enum DefaultPlaceHolderLinks:String{
    case user_avatar = "https://firebasestorage.googleapis.com/v0/b/pharmacy-app-969a3.appspot.com/o/user_avatar%2Fdefault_avatar.png?alt=media&token=a474fd44-d539-4622-a73e-ec5fab8e54c9"
    case store_logo = "https://firebasestorage.googleapis.com/v0/b/pharmacy-app-969a3.appspot.com/o/stores%2Fstore_placeholder.jpeg?alt=media&token=821358ba-5624-4b9f-ac58-b798225edd4b"
    case product_placeholder = "https://firebasestorage.googleapis.com/v0/b/pharmacy-app-969a3.appspot.com/o/products%2Fkingston-hospital.jpg?alt=media&token=d59470a7-e30a-442d-b616-72a38b50269d"
}

enum MapDelegateStatus: String {
    case searching, idle
}

enum ProductCategoryTypes: String {
    case HEART = "Heart"
    case CENTRAL_NEVRVOUS_SYSTEM = "Central Nervous System"
    case EAR_NOSE_THROAT = "Ear,Nose,Throat"
    case DIABETESE  = "Diabetes"
    case EYE  = "Eye"
    case GASTRO_INSTESTINAL  = "Gastro Intestinal"
}

public enum StatusType: String {
    case notAcceptable = "PENDING"
    case readyToPickup = "READYTOPICKUP"
    case completed = "COMPLETED"
    case cancle = "CANCLED"
}
