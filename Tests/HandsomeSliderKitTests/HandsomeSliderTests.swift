import XCTest
@testable import HandsomeSliderKit

final class HandsomeSliderTests: XCTestCase {
	
	var viewModel: SliderViewModel?
	let sliderWidth: Double = 100

	let sliderOption = SliderOption(id: "1", title: "One")
	let sliderOption2 = SliderOption(id: "2", title: "Two")
	let sliderOption3 = SliderOption(id: "3", title: "Three")
	let sliderOption4 = SliderOption(id: "4", title: "Four")
	let optionCount = 4
	
	override func setUp() {
		let options = [sliderOption, sliderOption2, sliderOption3, sliderOption4]
		viewModel = SliderViewModel(sliderOptions: options, viewWidth: sliderWidth)
	}
	
	func testFirstPosition() {
		XCTAssertEqual(viewModel?.firstPosition, -HandsomeSliderIndicator.radius)
	}
	
	func testLastPosition() {
		XCTAssertEqual(viewModel?.lastPosition, HandsomeSliderIndicator.radius)
	}
	
	func testSecondDotLocation() {
		let dotNumber: Int = 2
		let locationForSecondDot = viewModel?.getLocation(forDotNumber: dotNumber,
																											inListWithCount: optionCount,
																											viewWidth: sliderWidth)
		
		let assumedPosition = calculateAssumedPosition(forDotNumber: dotNumber,
																									 optionCount: optionCount,
																									 sliderWidth: sliderWidth)
		XCTAssertEqual(locationForSecondDot, assumedPosition)
	}
	
	func testThirdDotLocation() {
		let dotNumber: Int = 3
		let locationForSecondDot = viewModel?.getLocation(forDotNumber: dotNumber,
																											inListWithCount: optionCount,
																											viewWidth: sliderWidth)
		
		let assumedPosition = calculateAssumedPosition(forDotNumber: dotNumber,
																									 optionCount: optionCount,
																									 sliderWidth: sliderWidth)
		XCTAssertEqual(locationForSecondDot, assumedPosition)
	}
	
	func testDefaultColorScheme() {
		XCTAssertEqual(viewModel?.colorScheme.backgroundColor, .blue.opacity(0.2))
		XCTAssertEqual(viewModel?.colorScheme.dotColor, .white)
		XCTAssertEqual(viewModel?.colorScheme.indicatorColor, .blue)
	}
}

extension HandsomeSliderTests {
	func calculateAssumedPosition(forDotNumber dotNumber: Int, optionCount: Int, sliderWidth: Double) -> Double {
		let widthWithoutPadding = sliderWidth - (HandsomeSlider.insidePadding * 2) - (Dot.radius * 2)
		let firstPosition = -(widthWithoutPadding / 2)
		let assumedSecondDotPosition = firstPosition + (widthWithoutPadding / Double(optionCount - 1) * Double((dotNumber - 1)))
		return assumedSecondDotPosition
	}
}

extension Double {
	/// Rounds the double to decimal places value
	func roundToPlaces(places:Int) -> Double {
		let divisor = pow(10.0, Double(places))
		return ((self * divisor).rounded()) / divisor
	}
}
