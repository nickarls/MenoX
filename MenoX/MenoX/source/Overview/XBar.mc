class XBar {

	class Config {
		var alignment = 'L';
		var barWidth = 35;
		var barHeight = 10;
		var barSpacing = 3;
		var range = [60, 200];
		var valueFont = Graphics.FONT_MEDIUM;
		var valueColor = Graphics.COLOR_WHITE;
		var valueBackground = Graphics.COLOR_TRANSPARENT;
		var icon;
		
		function hasIcon() {
			return icon != null;
		}
	}
	
	hidden var config = new Config();
	
	function initialize(config) {
		self.config = config;
	}
	
	function draw(dc, value) {
		if (value == null) {
			value = 0;
		}
		var topY = drawBars(dc, value);
		drawValue(dc, topY, value);
		if (config.hasIcon()) {
			var coordinates = getIconCoordinates(dc);
			dc.drawBitmap(coordinates[0], coordinates[1], config.icon);
		}
	}
	
	hidden function drawValue(dc, topY, value) {
		dc.setColor(config.valueColor, config.valueBackground);
		var coordinates = getValueCoordinates(dc, topY, value);
		dc.drawText(coordinates[0], coordinates[1], config.valueFont, value, Graphics.TEXT_JUSTIFY_LEFT);
	}
	
	hidden function getValueCoordinates(dc, topY, value) {
		var textDimensions = dc.getTextDimensions(value.toString(), config.valueFont);
		var x = config.alignment == 'L' ? config.barWidth / 2 - textDimensions[0] / 2 : dc.getWidth() - config.barWidth / 2 - textDimensions[0] / 2;
		var y = topY - 2;
		return [x, y]; 	
	}
	
	hidden function drawBars(dc, value) {
		var valuePercent = getValuePercent(value);
		var topValue = dc.getHeight() * (1 - valuePercent);
		var currentY = dc.getHeight() - config.barHeight;
		var barCount = 0;
		var barColor;
		var x = config.alignment == 'L' ? 0 : dc.getWidth() - config.barWidth;
		while (currentY >= topValue) {
			barColor = getBarColor(barCount);
			dc.setColor(barColor, barColor);
			dc.fillRectangle(x, currentY, config.barWidth, config.barHeight);
			currentY = currentY - config.barHeight - config.barSpacing;
			barCount++;
		}
		return currentY - config.barHeight;
	}
	
	hidden function getIconCoordinates(dc) {
		var x = config.alignment == 'L' ? config.barWidth + 2 : dc.getWidth() - config.barWidth - config.icon.getWidth() - 2; 
		var y = dc.getHeight() - config.icon.getHeight();
		return [x, y];
	}
	
	hidden function getBarColor(i) {
		if (i <= 3) {
			return Graphics.COLOR_DK_GREEN;
		} else if (i >= 4 && i <= 7) {
			return Graphics.COLOR_GREEN;
		} else if (i >= 8 && i <= 11) {
			return Graphics.COLOR_YELLOW;
		} else if (i >= 12 && i <= 15) {
			return Graphics.COLOR_ORANGE;
		} else if (i >= 16 && i <= 19) {
			return Graphics.COLOR_RED;
		} else {
			return Graphics.COLOR_DK_RED;
		}
	}
	
	hidden function getValuePercent(value) {
		var lowValue = config.range[0];
		var highValue = config.range[1];
		var span = highValue - lowValue;
		var adjustedValue = value.toDouble() - lowValue;
		return adjustedValue / span.toDouble();
	}

}