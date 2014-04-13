<cfinclude template="../plugin/settings.cfm" />
<cfset pluginConfig = $.getPlugin(variables.settings.pluginName) />
<cfoutput>
<link rel="stylesheet" href="/plugins/#pluginConfig.getPackage()#/bootstrap-social/bootstrap-social.css">
<link rel="stylesheet" href="/plugins/#pluginConfig.getPackage()#/social.css">
</cfoutput>