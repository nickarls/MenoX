using Toybox.WatchUi;
using Toybox.System;

class PowerView extends BaseView {

	hidden var infoWrapper;
	
	hidden var powerData = [];
	hidden var normalizedPower;

	hidden var powerGraph;
	hidden var powerBars;

	function initialize() {
		BaseView.initialize();

		var background = loadResource(Rez.Drawables.EffortBarBackground);
		var powerBarConfig = new PowerBarConfig([0, 250], [0, 250], background, [5, 10, 15, 20, '*']);
		powerBars = new PowerBars(powerBarConfig);
		
		var powerGraphConfig = new PowerGraphConfig([251, 322], [0, 250]);
		powerGraph = new PowerGraph(powerGraphConfig);
		
		normalizedPower = new NormalizedPower();
	}
	
	function onInfo(infoWrapper) {
		self.infoWrapper = infoWrapper;
		if (infoWrapper.getCurrentPower() != null) {
			powerData.add(infoWrapper.getCurrentPower().toNumber());
			if (powerData.size() > 233) {
				powerData.remove(powerData[0]);
			}
			normalizedPower.addValue(infoWrapper.getCurrentPower());
			infoWrapper.setNormalizedPower(normalizedPower.getNP());
		}
		if (active) {
			requestUpdate();
		}
	}
		
	function onUpdate(dc) {
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
		dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
		
		powerBars.draw(dc, powerData);
		var np = infoWrapper == null ? 0 : infoWrapper.getNormalizedPower();
		powerGraph.draw(dc, powerData, np);
	}
	
	function onTimerState(state) {
	}
}