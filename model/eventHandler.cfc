component accessors=true extends='mura.plugin.pluginGenericEventHandler' output=false {
	
	include '../plugin/settings.cfm';

	public void function onApplicationLoad($) {
		// Register all event handlers/listeners of this .cfc with Mura CMS
		variables.pluginConfig.addEventHandler(this);	
		
	}

	// todo: by security hook profile update

	public void function onRenderStart($) {
		$.getContentRenderer().injectMethod('dspCustomDisplayObject', dspCustomDisplayObject);
	}

	public void function onSiteRequestStart($) {
		// Makes any methods of the object accessible via $.yourPluginPackageName
		var contentRenderer = new contentRenderer(arguments.$);
		arguments.$.setCustomMuraScopeKey(variables.settings.package, contentRenderer);
		
		variables.pluginConfig.setSetting(
			'SocialLoginService',
			new service.SocialLoginService(arguments.$, variables.pluginConfig)
		);
		
		variables.pluginConfig.setSetting('socialApi', new social.FacebookAPI(
			variables.pluginConfig.getSetting('socialLoginAppId'),
			variables.pluginConfig.getSetting('socialLoginAppSecret'),
			'email'
		));	
	}

	public string function onSiteLoginPromptRender($) {
		$.addToHTMLHeadQueue('/#variables.settings.package#/display_objects/htmlhead.cfm');
		
		return $.dspCustomDisplayObject('dsp_social_login.cfm');
	}

	public string function onSiteEditProfileRender($) {
		if ($.currentUser().getSubType() == 'Social Login'
			or not variables.pluginConfig.getSetting('socialKeepSync')) {

			$.addToHTMLHeadQueue('/#variables.settings.package#/display_objects/htmlhead.cfm');
			
			return $.dspCustomDisplayObject('dsp_social_edit_profile.cfm');
		} else {
			return "";
		}
	}

	public string function dspCustomDisplayObject(string displayObject) {
		// allow user to override the default Facebook login screen
		var output = $.dspObject_Include(theFile=arguments.displayObject, throwError='false');
		
		if (output == '') {
			savecontent variable='output' {
				include template='../display_objects/' & arguments.displayObject;
			}
		}

		return output;
	}

}