//
//  SignupForm.swift
//  BookShelf
//
//  Created by mac mini on 10/29/25.
//

import SwiftUI
import Combine

// MARK: - View Model
private class SignUpFormViewModel: ObservableObject {
  
  // MARK: Input
  @Published var username: String = ""
  @Published var password: String = ""
  @Published var passwordConfirmation: String = ""
  
  // MARK: Output
  @Published var usernameMessage: String = ""
  @Published var passwordMessage: String = ""
  @Published var isValid: Bool = false
  
  // MARK: Username validattion
  private lazy var isUsernameLengthValidPublisher: AnyPublisher<Bool, Never>  = {
    $username
      .map { $0.count >= 3 }
      .eraseToAnyPublisher()
  }()
  
  // MARK: Password validation
  private lazy var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> = {
    $password
      .map(\.isEmpty)
      // equivalent to
      // .map { $0.isEmpty }
      .eraseToAnyPublisher()
  }()
  
  private lazy var isPasswordMatchingPublisher: AnyPublisher<Bool, Never> = {
    Publishers.CombineLatest($password, $passwordConfirmation)
      .map(==)
      // equivalent to
      // .map { $0 == $1 }
      .eraseToAnyPublisher()
  }()
  
  private lazy var isPasswordValidPublisher: AnyPublisher<Bool, Never> = {
    Publishers.CombineLatest(isPasswordEmptyPublisher, isPasswordMatchingPublisher)
      .map { !$0 && $1 }
      .eraseToAnyPublisher()
  }()
  
  // MARK: Form validation
  private lazy var isFormValidPublisher: AnyPublisher<Bool, Never> = {
    Publishers.CombineLatest(isUsernameLengthValidPublisher, isPasswordValidPublisher)
      .map { $0 && $1 }
      .eraseToAnyPublisher()
  }()
  
  init() {
    isFormValidPublisher
      .assign(to: &$isValid)

    isUsernameLengthValidPublisher
      .map { $0 ? "" : "Username too short. Needs to be at least 3 characters." }
      .assign(to: &$usernameMessage)

    Publishers.CombineLatest(isPasswordEmptyPublisher, isPasswordMatchingPublisher)
      .map { isPasswordEmpty, isPasswordMatching in
        if isPasswordEmpty {
          return "Password must not be empty"
        }
        else if !isPasswordMatching {
          return "Passwords do not match"
        }
        return ""
      }
      .assign(to: &$passwordMessage)
  }
}

// MARK: - View
struct SignUpForm: View {
  @StateObject private var viewModel = SignUpFormViewModel()
  
  var body: some View {
    Form {
      // Username
      Section {
        TextField("Username", text: $viewModel.username)
          .autocapitalization(.none)
          .disableAutocorrection(true)
      } footer: {
        Text(viewModel.usernameMessage)
          .foregroundColor(.red)
      }
      
      // Password
      Section {
        SecureField("Password", text: $viewModel.password)
        SecureField("Repeat password", text: $viewModel.passwordConfirmation)
      } footer: {
        Text(viewModel.passwordMessage)
          .foregroundColor(.red)
      }
      
      // Submit button
      Section {
        Button("Sign up") {
          print("Signing up as \(viewModel.username)")
        }
        .disabled(!viewModel.isValid)
      }
    }
  }
}

// MARK: - Preview
struct SignUpForm_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      SignUpForm()
        .navigationTitle("Sign up")
    }
  }
}
