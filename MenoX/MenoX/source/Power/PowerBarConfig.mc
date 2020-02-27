class PowerBarConfig {
	hidden var yRange;
	hidden var powerRange;
	hidden var background;
	hidden var sampleSizes;
	
	function initialize(yRange, powerRange, background, sampleSizes) {
		self.yRange = yRange;
		self.powerRange = powerRange;
		self.background = background;
		self.sampleSizes = sampleSizes;
	}

	function getBarCount() {
		return sampleSizes.size();
	}

	function getBackgroundWidth() {
		return background.getWidth();
	}

	function getBackground() {
		return background;
	}

	function getSampleSize(i) {
		return sampleSizes[i];
	}
	
	function getBottomY() {
		return yRange[1];
	}
	
	function getValueInPercent(value) {
		var minPower = powerRange[0];
		var maxPower = powerRange[1];
		var range = maxPower - minPower;
		var adjustedValue = value - minPower;
		return adjustedValue / range.toDouble();
	}

/*	
	function getRange() {
		return maxPower - minPower;
	}
	
	function adjust(value) {
		return value - minPower;
	}
	
	
	
	
	function getGraphHeight(height) {
		return height * (heightPercent / 100.0);
	}
	
*/	
}