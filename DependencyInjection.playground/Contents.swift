//: Playground - noun: a place where people can play

import UIKit

//User model definition
struct User {
  let name: String
}

extension User: Hashable {
  var hashValue: Int {
    return name.hashValue
  }
  
  static func ==(lhs: User, rhs: User) -> Bool {
    return lhs.name == rhs.name
  }
}


//User Repo Protocol
protocol UserRepo {
  func getUsers() -> Set<User>
  func saveUsers(users: Set<User>)
}

//Realm UserRepo Implementation
class RealmUserRepo: UserRepo {
  
  func getUsers() -> Set<User> {
    //TODO: Add actual realm implementation
    return []
  }
  
  func saveUsers(users: Set<User>) {
    //TODO: Add actual realm implementation
  }
}

//Mock UserRepo Implementation
class MockUserRepo: UserRepo {
  var users: Set<User> = [
    User(name: "Joe"),
    User(name: "Mary")
  ]

  func getUsers() -> Set<User> {
    return users
  }
  
  func saveUsers(users: Set<User>) {
    self.users = users
  }
}

//User Store
class UserStore {
  private(set) var users: Set<User> = [] {
    didSet {
      userRepo.saveUsers(users: users)
    }
  }
  
  private let userRepo: UserRepo
  
  init(userRepo: UserRepo) {
    self.userRepo = userRepo
    users = userRepo.getUsers()
  }
}

//Actions
extension UserStore {
  func add(user: User) {
    users.update(with: user)
  }
  
  func removeUser(user: User) {
    users.remove(user)
  }
}

//Dependency Management
//let userRepo = RealmUserRepo()
let userRepo = MockUserRepo()
let userStore = UserStore(userRepo: userRepo)

let bob = User(name: "Bob")
let jane = User(name: "Jane")

userStore.add(user: bob)
userStore.add(user: jane)

userStore.users
