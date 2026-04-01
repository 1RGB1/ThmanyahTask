//
//  DurationFormatterTests.swift
//  ThmanyahTask
//
//  Created by Ahmad Ragab on 01/04/2026.
//  Copyright © 2026 Ahmad Ragab. All rights reserved.
//

import Foundation
import Testing
@testable import ThmanyahTask

struct DurationFormatterTests {

    @Test func nilReturnsEmpty() {
        #expect(DurationFormatter.format(second: nil) == "")
    }

    @Test func negativeReturnsEmpty() {
        #expect(DurationFormatter.format(second: -1) == "")
    }

    @Test func zeroReturnsZeroSeconds() {
        #expect(DurationFormatter.format(second: 0) == "0s")
    }

    @Test func secondsOnly() {
        #expect(DurationFormatter.format(second: 45) == "45s")
    }

    @Test func minutesOnly() {
        #expect(DurationFormatter.format(second: 120) == "2m")
    }

    @Test func minutesAndSeconds() {
        #expect(DurationFormatter.format(second: 90) == "1m 30s")
    }

    @Test func hoursOnly() {
        #expect(DurationFormatter.format(second: 3600) == "1h")
    }

    @Test func hoursAndMinutes() {
        #expect(DurationFormatter.format(second: 3660) == "1h 1m")
    }

    @Test func hoursMinutesAndSeconds() {
        #expect(DurationFormatter.format(second: 3661) == "1h 1m 1s")
    }

    @Test func largeValue() {
        #expect(DurationFormatter.format(second: 7200) == "2h")
    }

    @Test(
        "Various durations",
        arguments: [
            (600, "10m"),
            (1800, "30m"),
            (5400, "1h 30m"),
        ]
    )
    func parameterizedDurations(seconds: Int, expected: String) {
        #expect(DurationFormatter.format(second: seconds) == expected)
    }
}
