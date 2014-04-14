<cfsilent>
	<cfif not isdefined('request.userBean')>
		<cfset request.userBean=application.userManager.read(session.mura.userID) />
	</cfif>

	<cfparam name="msg" default="#variables.$.rbKey('user.message')#">
	<cfset variables.$.loadJSLib()>
	<cfset variables.$.addToHTMLHeadQueue("htmlEditor.cfm")>
</cfsilent>
<cfoutput>
	<#variables.$.getHeaderTag('headline')#><cfif not session.mura.isLoggedIn>#variables.$.rbKey('user.createprofile')#<cfelse>#variables.$.rbKey('user.editprofile')#</cfif></#variables.$.getHeaderTag('headline')#>

	<cfif not(structIsEmpty(request.userBean.getErrors()) and request.doaction eq 'createprofile')>
		<div id="svEditProfile" class="mura-edit-profile #this.editProfileWrapperClass#">

		<a href="https://www.facebook.com/settings?tab=account" target="_blank" class="btn btn-social-icon btn-xs btn-facebook"><i class="fa fa-facebook"></i></a> You're connected thanks to your Facebook account. Click the icon to review your details.
		</div>

	<cfelse>

		<!--- This is where the script for a newly created account does if inactive is default to 1 for new accounts--->
		<cfsilent>
			<cfif request.userBean.getInActive() and len(getSite().getExtranetPublicRegNotify())>
			<cfsavecontent variable="notifyText"><cfoutput>
			A new registration has been submitted to #getSite().getSite()#

			Date/Time: #now()#
			#variables.$.rbKey('user.email')#: #request.userBean.getEmail()#
			#variables.$.rbKey('user.username')#: #request.userBean.getUserName()#
			#variables.$.rbKey('user.fname')#: #request.userBean.getFname()#
			#variables.$.rbKey('user.lname')#: #request.userBean.getLname()#
			</cfoutput></cfsavecontent>
			<cfset email=variables.$.getBean('mailer') />
			<cfset email.sendText(notifyText,
							getSite().getExtranetPublicRegNotify(),
							getSite().getSite(),
							'#getSite().getSite()# Public Registration',
							variables.$.event('siteID')) />

			</cfif>
		</cfsilent>

		<cfif request.userBean.getInActive()>
			<div class="#this.alertDangerClass#">
				<p class="#this.editProfileSuccessMessageClass#">#variables.$.rbKey('user.thankyouinactive')#</p>
			</div>
		<cfelse>
			<div class="#this.alertDangerClass#"><p class="#this.editProfileSuccessMessageClass#">#variables.$.rbKey('user.thankyouactive')#</p></div>
		</cfif>
	</cfif>
</cfoutput>
