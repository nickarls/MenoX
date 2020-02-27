class Speed {

	class Config {
		var center;
		var backgroundColor = Graphics.COLOR_TRANSPARENT;
		var	currentSpeedFont = Graphics.FONT_NUMBER_THAI_HOT;
		var currentSpeedColor = Graphics.COLOR_WHITE;
		var averageSpeedFont = Graphics.FONT_MEDIUM;
		var averageSpeedColor = Graphics.COLOR_LT_GRAY;
		var circleRadius;	// = 100;
		var circleWidth;	// = 1;
		var circleColor;	// = Graphics.COLOR_LT_GRAY;
	}
	
	hidden var config = new Config();

	function initialize(config) {
		self.config = config;
	}

	function draw(dc, speeds) {
		var currentSpeed = speeds[0];
		var averageSpeed = speeds[1];
		
		drawCurrentSpeed(dc, currentSpeed);
		drawAverageSpeed(dc, averageSpeed);
		
		if (config.circleRadius != null) {
			drawCircle(dc);
		}
	}
	
	hidden function drawCircle(dc) {
		dc.setColor(config.circleColor, config.backgroundColor);
		dc.setPenWidth(config.circleWidth);
		var origo = getOrigo(dc);
		dc.drawCircle(origo[0], origo[1], config.circleRadius);
	}

	hidden function drawCurrentSpeed(dc, speed) {
		var origo = getOrigo(dc);
		var text = speed.toString();
		var coordinates = getTextCoordinates(dc, origo, text, config.currentSpeedFont);
		dc.setColor(config.currentSpeedColor, config.backgroundColor);
		dc.drawText(coordinates[0], coordinates[1], config.currentSpeedFont, text, Graphics.TEXT_JUSTIFY_LEFT);
	}

	hidden function drawAverageSpeed(dc, speed) {
		var origo = getOrigo(dc);
		var text = speed.toString();
		var coordinates = getTextCoordinates(dc, origo, text, config.averageSpeedFont);
		coordinates[1] += dc.getFontHeight(config.averageSpeedFont) + 5;
		dc.setColor(config.averageSpeedColor, config.backgroundColor);
		dc.drawText(coordinates[0], coordinates[1], config.averageSpeedFont, text, Graphics.TEXT_JUSTIFY_LEFT);
	}

	hidden function getOrigo(dc) {
		if (config.center != null) {
			return config.center;
		} else {
			return [dc.getWidth() / 2, dc.getHeight() / 2];
		}
	}

	hidden function getTextCoordinates(dc, origo, text, font) {
		var textDimensions = dc.getTextDimensions(text, font);
		return [origo[0] - textDimensions[0] / 2, origo[1] - textDimensions[1] / 2];
	}	

}