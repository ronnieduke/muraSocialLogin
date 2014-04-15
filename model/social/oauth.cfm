<cfset mysession = pluginConfig.getSetting("socialApi").getCurrentSession() />

<cfif url.keyExists("code") and url.keyExists("state")>

	<cfif mysession.oauth(url.code, url.state)>
	
		<cfset me = mysession.graph('/me') />
		<cfset pluginConfig.getSetting("SocialLoginService").login(me, pluginConfig.getSetting("socialLoginDefaultGroups")) />
		<cflocation url="#mysession.getTarget()#" addtoken="false" />
	</cfif>
 
<cfelseif isDefined("url.error_reason")>
	 
	<!--- Handle error here. Variables are:
	url.error_reason and error_description
	<cfdump eval="url" />
	--->
	<cfdump eval="url" />
	<!---
	<cflocation url="#mysession.getTarget()##application.settingsManager.getSite($.event('siteID')).getLoginURL()#" addtoken="false" />
	--->
</cfif>
