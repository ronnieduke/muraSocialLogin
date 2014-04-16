<cfinclude template="settings.cfm" />
<cfoutput>
<plugin>

	<!-- Name : the name of the plugin -->
	<name>#variables.settings.pluginName#</name>

	<!-- Package : a unique, variable-safe name for the plugin -->
	<package>#variables.settings.package#</package>

	<!--
		DirectoryFormat : 
		This setting controls the format of the plugin directory.
			* default : /plugins/{packageName}_{autoIncrement}/
			* packageOnly : /plugins/{packageName}/
	-->
	<directoryFormat>packageOnly</directoryFormat>

	<!--
		LoadPriority : 
		Options are 1 through 10.
		Determines the order that the plugins will fire during the
		onApplicationLoad event. This allows plugins to use other
		plugins as services. This does NOT affect the order in which
		regular events are fired.
	-->
	<loadPriority>#variables.settings.loadPriority#</loadPriority>

	<!-- Version : Meta information. May contain any value you wish. -->
	<version>#variables.settings.version#</version>

	<!--
		Provider : 
		Meta information. The name of the creator/organization that
		developed the plugin.
	-->
	<provider>#variables.settings.provider#</provider>

	<!--
		ProviderURL : 
		URL of the creator/organization that developed the plugin.
	-->
	<providerURL>#variables.settings.providerURL#</providerURL>

	<!-- Category : Usually either 'Application' or 'Utility' -->
	<category>#variables.settings.category#</category>
	
	<!--
		ORMCFCLocation : 
		May contain a list of paths where Mura should look for 
		custom ORM components.
	-->
	<!-- <ormCFCLocation>/extensions/orm</ormCFCLocation> -->

	<!-- 
		CustomTagPaths : 
		May contain a list of paths where Mura should look for
		custom tags.
	-->
	<!-- <customTagPaths></customTagPaths> -->

	<!--
		Mappings :
		Allows you to define custom mappings for use within your plugin.
	-->
	<mappings>
		<!--
		<mapping
			name="myMapping"
			directory="someDirectory/anotherDirectory" />
		-->
		<!--
			Mappings will automatically be bound to the directory
			your plugin is installed, so the above example would
			refer to: {context}/plugins/{packageName}/someDirectory/anotherDirectory/
		-->
	</mappings>

	<!--
		AutoDeploy :
		Works with Mura's plugin auto-discovery feature. If true,
		every time Mura loads, it will look in the /plugins directory
		for new plugins and install them. If false, or not defined,
		Mura will register the plugin with the default setting values,
		but a Super Admin will need to login and manually complete
		the deployment.
	-->
	<!-- <autoDeploy>false|true</autoDeploy> -->

	<!--
		SiteID :
		Works in conjunction with the autoDeploy attribute.
		May contain a comma-delimited list of SiteIDs that you would
		like to assign the plugin to during the autoDeploy process.
	-->
	<!-- <siteID></siteID> -->

	<!-- 
			Plugin Settings :
			The settings contain individual settings that the plugin
			requires to function.
	-->
	<settings>
		<setting>
			<name>socialLoginAppId</name>
			<label>Facebook App Id</label>
			<hint>Your Facebook App Id.</hint>
			<type>TextBox</type>
			<required>true</required>
			<validation>None</validation>
			<message>The Facebook App Id is required</message>
		</setting>
		<setting>
			<name>socialLoginAppSecret</name>
			<label>Facebook App Secret</label>
			<hint>Your Facebook App Secret.</hint>
			<type>TextBox</type>
			<required>true</required>
			<validation>None</validation>
			<message>The Facebook App Secret is required</message>
		</setting>
		<setting>
			<name>socialLoginButtonSize</name>
			<label>Button size</label>
			<hint>The button size class to be apply.</hint>
			<type>select</type>
			<required>true</required>
			<validation>None</validation>
			<regex></regex>
			<message>The Facebook App Secret is required</message>
			<defaultValue></defaultValue>
			<optionList>btn-lg^btn^btn-sm^btn-xs</optionList>
			<optionLabelList>Large button^Default button^Small button^Extra small button</optionLabelList>
		</setting>
		<setting>
			<name>socialDefaultRedirect</name>
			<label>Default member groups assignation</label>
			<hint>The default absolute URL where to redirect to after Login page. This param is overridden by the redirectURL attribute (in URL).</hint>
			<defaultValue>/</defaultValue>
			<type>TextBox</type>
			<required>true</required>
			<validation>None</validation>
		</setting>
		<setting>
			<name>socialLoginDefaultGroups</name>
			<label>Default member groups assignation</label>
			<hint>List of group names to assign new users to (separated by coma). Leave blank to not assign to a group.</hint>
			<type>TextBox</type>
			<required>false</required>
			<validation>None</validation>
		</setting>
		<setting>
			<name>socialKeepSync</name>
			<label>Keep profile synchronized from Social Network.</label>
			<hint>Yes to activate the profile information synchronization. No to allow users modifying their profile.</hint>
			<defaultValue>true</defaultValue>
			<type>RadioGroup</type>
			<required>True</required>
			<validation>None</validation>
			<optionList>true^false</optionList>
			<optionLabelList>Yes^No</optionLabelList>
		</setting>
	</settings>

	<!-- Event Handlers -->
	<eventHandlers>
		<!-- only need to register the eventHandler.cfc via onApplicationLoad() -->
		<eventHandler 
			event="onApplicationLoad" 
			component="model.eventHandler" 
			persist="false" />
	</eventHandlers>

	<!--
		Display Objects :
		Allows developers to provide widgets that end users can apply to a
		content node's display region(s) when editing a page. They'll be
		listed under the Layout & Objects tab. The 'persist' attribute
		for CFC-based objects determine whether they are cached or instantiated
		on a per-request basis.
	-->
	<displayobjects location="global">
	
		<displayobject name="Social Login form"
			displayobjectfile="display_objects/dsp_social_user_tools.cfm" />

	</displayobjects>

	<!-- 
		Extensions :
		Allows you to create custom Class Extensions of any type.
		See /default/includes/themes/MuraBootstrap/config.xml.cfm
		for examples.
	-->
	<extensions>
		<extension type="User" subType="Social Login">
			<!--
			<attributeset name="Social Options" container="Basic">
			-->
				<!-- Todo: type the social network as soon as we integrate more than Facebook
				<attribute 
					name="social-network"
					label="Social Network"
					hint=""
					type="SelectBox"
					defaultValue=""
					required="true"
					optionList="fb"
					optionLabelList="Facebook" />
				-->
				<!-- todo: preserve RemoteID for other usages
				(improve backward compatibility to be integrated into existing systems)
				<attribute 
					name="social-id"
					label="External ID"
					hint="This is the internal ID of the social Network."
					type="TextBox"
					defaultValue=""
					required="true"
					validation="Numeric" />
				-->
			<!--
			</attributeset>
			-->
		</extension>
	</extensions>

</plugin>
</cfoutput>