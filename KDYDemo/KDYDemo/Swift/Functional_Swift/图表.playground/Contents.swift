//: Playground - noun: a place where people can play

import UIKit

var str = "图表"

/**
 *  1 绘制正方形和圆
 */

extension SequenceType where Generator.Element == CGFloat {
    func normalize() -> [CGFloat] {
        let maxVal = self.reduce(0) { max($0, $1) }
        return self.map { $0 / maxVal
        }
    }
}



























