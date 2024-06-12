import SwiftUI

struct CircleAccuracyCalculator {
    static func calculateScore(from points: [CGPoint]) -> Double {
        if let center = calculateCenter(of: points), let radius = calculateRadius(from: center, points: points) {
            return calculateCircleAccuracy(center: center, radius: radius, points: points)
        } else {
            return 0.0
        }
    }

    private static func calculateCenter(of points: [CGPoint]) -> CGPoint? {
        guard points.count > 1 else { return nil }
        
        var xTotal: CGFloat = 0
        var yTotal: CGFloat = 0
        
        for point in points {
            xTotal += point.x
            yTotal += point.y
        }
        
        return CGPoint(x: xTotal / CGFloat(points.count), y: yTotal / CGFloat(points.count))
    }

    private static func calculateRadius(from center: CGPoint, points: [CGPoint]) -> CGFloat? {
        guard points.count > 1 else { return nil }
        
        var totalRadius: CGFloat = 0
        
        for point in points {
            let dx = point.x - center.x
            let dy = point.y - center.y
            totalRadius += sqrt(dx * dx + dy * dy)
        }
        
        return totalRadius / CGFloat(points.count)
    }

    private static func calculateCircleAccuracy(center: CGPoint, radius: CGFloat, points: [CGPoint]) -> Double {
        var totalDifference: CGFloat = 0
        
        for point in points {
            let dx = point.x - center.x
            let dy = point.y - center.y
            let distance = sqrt(dx * dx + dy * dy)
            totalDifference += abs(distance - radius)
        }
        
        let averageDifference = totalDifference / CGFloat(points.count)
        let accuracyScore = max(0, 100 - Double(averageDifference))
        
        return accuracyScore
    }
}
