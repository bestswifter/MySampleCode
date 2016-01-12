//
//  Tree.swift
//  Enum
//
//  Created by 张星宇 on 16/1/12.
//  Copyright © 2016年 张星宇. All rights reserved.
//

import Foundation

/**
 节点颜色
 */
enum Color { case R, B }

/**
用枚举定义一颗红黑树

- Empty: 值为Empty表示是空的
- Node: 表示这是一个非空节点
*/
indirect enum Tree<Element: Comparable> {
    case Empty
    case Node(Color,Tree<Element>,Element,Tree<Element>)
    
    init() { self = .Empty }  //创建空红黑树
    
    /**
    创建非空红黑树
    
    :param: x     根节点存储的值
    :param: color 根节点的颜色，默认为黑丝
    :param: left  左子树，默认为空树
    :param: right 右子树，默认为空树
    
    :returns: 返回创建好了的红黑树
    */
    init(_ x: Element, color: Color = .B,
        left: Tree<Element> = .Empty, right: Tree<Element> = .Empty){
        self = .Node(color, left, x, right)
    }
}

/**
 向红黑树中插入新的元素
 
 :param: into 原来的树
 :param: x    新插入的值
 
 :returns: 插入值后的树
 */
private func ins<T>(into: Tree<T>, _ x: T) -> Tree<T> {
    /// 如果原来的树为空，就返回一颗新建的数，根节点的值为x
    guard case let .Node(c, l, y, r) = into
        else { return Tree(x, color: .R) }
    
    if x < y { return balance(Tree(y, color: c, left: ins(l,x), right: r)) }
    if y < x { return balance(Tree(y, color: c, left: l, right: ins(r, x))) }
    return into
}

/**
 平衡红黑树，需要调整元素的位置与颜色
 
 :param: tree 需要处理的树
 
 :returns: 处理后的树
 */
private func balance<T>(tree: Tree<T>) -> Tree<T> {
    switch tree {
    case let .Node(.B, .Node(.R, .Node(.R, a, x, b), y, c), z, d):
        return .Node(.R, .Node(.B,a,x,b),y,.Node(.B,c,z,d))
    case let .Node(.B, .Node(.R, a, x, .Node(.R, b, y, c)), z, d):
        return .Node(.R, .Node(.B,a,x,b),y,.Node(.B,c,z,d))
    case let .Node(.B, a, x, .Node(.R, .Node(.R, b, y, c), z, d)):
        return .Node(.R, .Node(.B,a,x,b),y,.Node(.B,c,z,d))
    case let .Node(.B, a, x, .Node(.R, b, y, .Node(.R, c, z, d))):
        return .Node(.R, .Node(.B,a,x,b),y,.Node(.B,c,z,d))
    default:
        return tree
    }
}

// MARK: - 实现contains方法
extension Tree {
    /**
     判断树中是否包含某个元素，递归实现
     
     :param: x 待寻找的元素
     
     :returns: 是否找到
     */
    func contains(x: Element) -> Bool {
        guard case let .Node(_,left,y,right) = self
            else { return false }
        
        if x < y { return left.contains(x) }
        if y < x { return right.contains(x) }
        return true
    }
}

// MARK: - 实现insert方法
extension Tree {
    /**
     向树中插入新的元素，返回值可能是一颗新的树而非原来的树
     
     :param: x 新插入的元素
     
     :returns: 插入元素后的树
     */
    func insert(x: Element) -> Tree {
        guard case let .Node(_,l,y,r) = ins(self, x)
            else { fatalError("ins should never return an empty tree") }
        
        return .Node(.B,l,y,r)
    }
}

// MARK: - 实现SequenceType协议，遍历树
extension Tree: SequenceType {
    /**
     中序遍历树
     
     :returns: 返回一个生成器，通过for循环遍历树，在main.swift中对这个方法进行了测试
     */
    func generate() -> AnyGenerator<Element> {
        var stack: [Tree] = []
        var current: Tree = self
        
        return anyGenerator { _ -> Element? in
            while true {
                // if there's a left-hand node, head down it
                if case let .Node(_,l,_,_) = current {
                    stack.append(current)
                    current = l
                }
                    // if there isn’t, head back up, going right as
                    // soon as you can:
                else if !stack.isEmpty, case let .Node(_,_,x,r) = stack.removeLast() {
                    current = r
                    return x
                }
                else {
                    // otherwise, we’re done
                    return nil
                }
            }
        }
    }
}

// MARK: - 实现ArrayLiteralConvertible协议，通过数组字面量生成红黑树
extension Tree: ArrayLiteralConvertible {
    /**
     初始化方法，把数组中每个元素插入到树中
     
     :param: source 数组字面量
     
     :returns: 初始化完成的树
     */
    init <S: SequenceType where S.Generator.Element == Element>(_ source: S) {
        self = source.reduce(Tree()) { $0.insert($1) }
    }
    
    init(arrayLiteral elements: Element...) {
        self = Tree(elements)
    }
}