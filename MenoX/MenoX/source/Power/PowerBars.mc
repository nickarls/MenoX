using Toybox.System;

class PowerBars {

	hidden var config;
	hidden var barXLocations = [];
	
	function initialize(config) {
		self.config = config;
		barXLocations = calculateBarXLocations(config.getBarCount(), System.getDeviceSettings().screenWidth, config.getBackgroundWidth());
	}
	
	hidden function calculateBarXLocations(barCount, screenWidth, backgroundWidth) {
		var locations = [];
		
		var barSpace = barCount * backgroundWidth;
		var freeSpace = screenWidth - barSpace;
		var spacing = freeSpace / (barCount + 1);
		
		for (var i = 0; i < barCount; i++) {
			locations.add(spacing * (i + 1) + backgroundWidth * i);
		}
		return locations;
	}
	
	function draw(dc, data) {
		for (var i = 0; i < config.getBarCount(); i++) {
			drawBar(dc, barXLocations[i], config.getSampleSize(i), data);
		}
	}
	
	hidden function drawBar(dc, x, sampleSize, data) {
		dc.setClip(0, 0, dc.getWidth(), config.getBottomY());
		drawBackground(dc, x);
		drawSampleSize(dc, x, sampleSize);
		var value = getValue(sampleSize, data);
		var coveredPercent = 1 - config.getValueInPercent(value);
		drawCover(dc, x, coveredPercent);
		drawValue(dc, x, coveredPercent, value);
		dc.clearClip();
	}
	
	hidden function drawValue(dc, x, coveredPercent, value) {
		var y = coveredPercent * System.getDeviceSettings().screenHeight;
		var backgroundWidth = config.getBackgroundWidth();
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		var textDimensions = dc.getTextDimensions(value.toString(), Graphics.FONT_SMALL);
		var adjustedX = x + backgroundWidth / 2 - textDimensions[0] / 2;
		var adjustedY = y - textDimensions[1];
		if (adjustedY < 0) {
			adjustedY = 0;
		}
		dc.drawText(adjustedX, adjustedY, Graphics.FONT_SMALL, value, Graphics.TEXT_JUSTIFY_LEFT);		
	}
	
	hidden function drawBackground(dc, x) {
		dc.drawBitmap(x, 0, config.getBackground());
	}
	
	hidden function drawCover(dc, x, coveredPercent) {
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
		var height = coveredPercent * System.getDeviceSettings().screenHeight;
		dc.fillRectangle(x, 0, config.getBackgroundWidth(), height);
	}
	
	hidden function getValue(sampleSize, data) {
		if (sampleSize == '*') {
			sampleSize = data.size();
		}
		var dataSize = data.size();
		var useData = data.slice(dataSize - sampleSize, dataSize);
		var average = getAverage(useData);
		return average;
	}
	
	hidden function getAverage(data) {
		if (data.size() == 0) {
			return 0;
		}
		var sum = 0;
		for (var i = 0; i < data.size(); i++) {
			sum += data[i];
		}
		return sum / data.size();
	}
	
	hidden function drawSampleSize(dc, x, sampleSize) {
		var backgroundWidth = config.getBackgroundWidth();
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		var textDimensions = dc.getTextDimensions(sampleSize.toString(), Graphics.FONT_SMALL);
		var adjustedX = x + backgroundWidth / 2 - textDimensions[0] / 2;
		var adjustedY = config.getBottomY() - textDimensions[1];
		dc.drawText(adjustedX, adjustedY, Graphics.FONT_SMALL, sampleSize, Graphics.TEXT_JUSTIFY_LEFT);
	}
	
}