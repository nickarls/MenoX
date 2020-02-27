class PowerGraphConfig {
	hidden var yRange;
	hidden var powerRange;
	
	function initialize(yRange, powerRange) {
		self.yRange = yRange;
		self.powerRange = powerRange;
	}
	
	function getBottomY() {
		return yRange[1];
	}
	
	function getValueInPercent(value) {
		var minPower = powerRange[0];
		var maxPower = powerRange[1];
		var range = maxPower - minPower;
		var adjustedValue = value - minPower;
		var percent = adjustedValue / range.toDouble();
		if (percent > 1) {
			percent = 1;
		}
		return percent;
	}
	
	function getYRange() {
		var top = yRange[0];
		var bottom = yRange[1];
		return bottom - top;
	}	
}