class PowerGraph {

	hidden var config;

	function initialize(config) {
		self.config = config;
	}

	function draw(dc, data, normalizedPower) {
		var value;
		var lineLength;
		dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLUE);
		for (var i = 0; i < data.size(); i++) {
			value = data[i];
			lineLength = getLineLength(dc, value);
			dc.drawLine(i, config.getBottomY(), i, config.getBottomY() - lineLength);
		}
		drawNormalizedPower(dc, normalizedPower);
	}
	
	hidden function drawNormalizedPower(dc, normalizedPower) {
		var text = "NP " + normalizedPower + "W";
		var textDimensions = dc.getTextDimensions(text, Graphics.FONT_MEDIUM);
		var x = dc.getWidth() / 2 - textDimensions[0] / 2;
		var y = config.getBottomY() - textDimensions[1];
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		dc.drawText(x, y, Graphics.FONT_MEDIUM, text, Graphics.TEXT_JUSTIFY_LEFT);
	}
	
	hidden function getLineLength(dc, value) {
		var percent = config.getValueInPercent(value);
		var lineLength = percent * config.getYRange();
		return lineLength;		
	}

}