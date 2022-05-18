//
//  Animator.swift
//  MovieCase
//
//  Created by ugur-pc on 18.05.2022.
//

import UIKit

protocol Animator: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}
