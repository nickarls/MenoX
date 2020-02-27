class Clock {

	class Config {
		var center;
		var font = Graphics.FONT_SMALL;
		var color = Graphics.COLOR_BLUE;
		var background = Graphics.COLOR_TRANSPARENT;
	}
	
	var config = new Config();
	
	function initialize(config) {
		self.config = config;
	}

	function draw(dc, time) {
		var origo = getOrigo(dc);
		var coordinates = getTextCoordinates(dc, origo, time, config.font);
		dc.setColor(config.color, config.background);
		dc.drawText(coordinates[0], coordinates[1], config.font, time, Graphics.TEXT_JUSTIFY_LEFT);
	}
	
	hidden function getTextCoordinates(dc, origo, text, font) {
		var textDimensions = dc.getTextDimensions(text, font);
		return [origo[0] - textDimensions[0] / 2, origo[1] - textDimensions[1]];
	}		
	
	function getOrigo(dc) {
		if (config.center != null) {
			return config.center;
		} else {
			return [dc.getWidth() / 2, dc.getHeight()];
		}
	}
	
}