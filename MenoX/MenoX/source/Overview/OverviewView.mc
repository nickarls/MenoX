using Toybox.WatchUi;

class OverviewView extends BaseView {
	hidden var infoWrapper;
	
	hidden var speed;
	hidden var clock;
	hidden var sessionTime;
	
	hidden var heartRate;
	hidden var power;
	
	hidden var controller;
	
	function initialize(controller) {
		BaseView.initialize();
		self.controller = controller;
		
		var heartRateConf = new XBar.Config();
		heartRateConf.icon = loadResource(Rez.Drawables.RedHeart);
		heartRate = new XBar(heartRateConf);
		
		var powerConf = new XBar.Config();
		powerConf.icon = loadResource(Rez.Drawables.Lightning);
		powerConf.range = [0, 300];
		powerConf.alignment = 'R';
		power = new XBar(powerConf);
		
		speed = new Speed(new Speed.Config());
		clock = new Clock(new Clock.Config());
		sessionTime = new SessionTime(new SessionTime.Config());
	}
	
	function onInfo(infoWrapper) {
		self.infoWrapper = infoWrapper;
		if (active) {
			requestUpdate();
		}
	}
		
	function onUpdate(dc) {
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
		dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

		if (infoWrapper == null || !infoWrapper.isReady()) {
			drawBike(dc);
			drawLogo(dc);
			return;
		}

		speed.draw(dc, [infoWrapper.getCurrentSpeed(), infoWrapper.getAverageSpeed()]);		
		heartRate.draw(dc, infoWrapper.getCurrentHeartRate());
		power.draw(dc, infoWrapper.getCurrentPower());
		clock.draw(dc, infoWrapper.getWallClockTime());
		sessionTime.draw(dc, infoWrapper.getSessionTime());
		
		if (controller.isStopped()) {
			drawStopFrame(dc);
		}
	}
	
	hidden function drawStopFrame(dc) {
		dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_RED);
		dc.setPenWidth(5);
		dc.drawRectangle(0, 0, dc.getWidth(), dc.getHeight());
	}

	hidden function drawBike(dc) {
		var bike = loadResource(Rez.Drawables.Bike);
		var x = dc.getWidth() / 2 - bike.getWidth() / 2;
		var y = dc.getHeight() / 2 - bike.getHeight() / 2;			
		dc.drawBitmap(x, y, bike);
	}
	
	hidden function drawLogo(dc) {
		var text = "MenoX";
		var font = Graphics.FONT_LARGE;
		dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
		var textDimensions = dc.getTextDimensions(text, font);
		var x = dc.getWidth() / 2 - textDimensions[0] / 2;
		var y = dc.getHeight() - 80;
		dc.drawText(x, y, font, text, Graphics.TEXT_JUSTIFY_LEFT);
		
	}

	function onTimerState(state) {
		requestUpdate();
	}

}