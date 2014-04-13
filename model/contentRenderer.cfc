component accessors=true extends='mura.cfobject' output=false {

	property name='$';

	include '../plugin/settings.cfm';

	public any function init(required struct $) {
		set$(arguments.$);
		return this;
	}

	public any function getPluginConfig() {
		return $.getPlugin(variables.settings.pluginName);
	}

}