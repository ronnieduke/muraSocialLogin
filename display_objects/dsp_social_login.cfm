<cfif not isBoolean(variables.$.event('isBlocked'))>
	<cfset variables.$.event('isBlocked',false)>
</cfif>
<cfoutput>
	<div id="svLoginContainer" class="mura-login-container #this.loginWrapperClass#">
		<div class="#this.loginWrapperInnerClass#">
			<#variables.$.getHeaderTag('subhead1')#>#variables.$.content('title')#</#variables.$.getHeaderTag('subhead1')#>

			<!--- 
				SUMMARY
				The page summary can be used to show some content before the user has logged in. 
				Outputs only if there is content in the summary field. 
			--->
			#variables.$.content('summary')#

			<cfif variables.$.event('status') eq 'failed'>
				<cfif isDate(session.blockLoginUntil) and session.blockLoginUntil gt now()>
				<cfset variables.$.event('isBlocked',true) />
				<p id="loginMsg" class="#this.alertDangerClass#">#variables.$.rbKey('user.loginblocked')#</p>
				<cfelse>
				<p id="loginMsg" class="#this.alertDangerClass#">#variables.$.rbKey('user.loginfailed')#</p>
				</cfif>
			</cfif>

			<cfif not variables.$.event('isBlocked')>				
				<form role="form" id="login" class="mura-login-form #this.loginFormClass# <cfif this.formWrapperClass neq "">#this.formWrapperClass#</cfif>" name="frmLogin" method="post" action="?nocache=1" onsubmit="return validate(this);" novalidate="novalidate">
					<fieldset>
						<legend>#variables.$.rbKey('user.pleaselogin')#</legend>

						<!--- Facebook addition --->
						<cfset mysession = $.socialLogin.getPluginConfig().getSetting("socialApi").getCurrentSession(true) />

						<div class="#this.loginFormGroupWrapperClass#">
							<label class="#this.loginFormFieldLabelClass#"></label>
							<div class="#this.loginFormFieldWrapperClass#">
								<a class="btn btn-block btn-social #$.socialLogin.getPluginConfig().getSetting("socialLoginButtonSize")# btn-facebook" href="#mysession.connect(variables.$.event('returnURL'))#">
								<i class="fa fa-facebook"></i> Sign in with Facebook
								</a><br/>
								<strong class="line-thru">or</strong>
							</div>
						</div>

						<!--- Username --->
						<div class="req #this.loginFormGroupWrapperClass#">
							<label for="txtUsername" class="#this.loginFormFieldLabelClass#">
								#variables.$.rbKey('user.username')#
								<ins>(#HTMLEditFormat(variables.$.rbKey('user.required'))#)</ins>
							</label>
							<div class="#this.loginFormFieldWrapperClass#">
								<input class="#this.loginFormFieldClass#" type="text" id="txtUsername" placeholder="#variables.$.rbKey('user.username')#" name="username" required="true" message="#htmlEditFormat(variables.$.rbKey('user.usernamerequired'))#" autofocus>
							</div>
						</div>
	
						<!--- Password --->
						<div class="req #this.loginFormGroupWrapperClass#">
							<label for="txtPassword" class="#this.loginFormFieldLabelClass#">
								#variables.$.rbKey('user.password')#
								<ins>(#HTMLEditFormat(variables.$.rbKey('user.required'))#)</ins>
							</label>
							<div class="#this.loginFormFieldWrapperClass#">
								<input class="#this.loginFormFieldClass#" type="password" id="txtPassword" name="password" placeholder="#variables.$.rbKey('user.password')#" required="true" message="#htmlEditFormat(variables.$.rbKey('user.passwordrequired'))#">
							</div>
						</div>
	
						<!--- Remember Me --->
						<div class="#this.loginFormGroupWrapperClass#">
							<div class="#this.loginFormPrefsClass#">
								<label class="#this.loginFormCheckboxClass#" for="cbRememberMe" >
									<input type="checkbox" id="cbRememberMe" name="rememberMe" value="1"> #htmlEditFormat(variables.$.rbKey('user.rememberme'))#
								</label>
							</div>
						</div>
	
						<!--- Login Button --->
						<div class="#this.loginFormGroupWrapperClass#">
							<div class="#this.loginFormSubmitWrapperClass#">
								<button type="submit" class="#this.loginFormSubmitClass#">#htmlEditFormat(variables.$.rbKey('user.login'))#</button>
							</div>
						</div>
	
						<input type="hidden" name="doaction" value="login">
						<input type="hidden" name="linkServID" value="#HTMLEditFormat(variables.$.event('linkServID'))#">
						<input type="hidden" name="returnURL" value="#HTMLEditFormat(variables.$.event('returnURL'))#">
					</fieldset>
				</form>


				<cfif variables.$.event('doaction') eq 'sendlogin'>
					<cfset msg2=application.userManager.sendLoginByEmail(variables.$.event('email'), variables.$.event('siteID'),'#urlencodedformat(variables.$.event('returnURL'))#')>
				</cfif>

				<!--- Forgot Username / Password Form --->
				<form name="form2" class="mura-send-login #this.forgotPasswordFormClass# <cfif this.formWrapperClass neq "">#this.formWrapperClass#</cfif>" method="post" action="?nocache=1" id="sendLogin" onsubmit="return validate(this);" novalidate="novalidate">
					<fieldset>
						<legend>#variables.$.rbKey('user.forgetusernameorpassword')#</legend>
						<p>#variables.$.rbKey('user.forgotloginmessage')#</p>
	
						<cfif isdefined('msg2')>
							<cfif FindNoCase('is not a valid',msg2)><div class="#this.loginFormErrorClass#">#HTMLEditFormat(variables.$.siteConfig("rbFactory").getResourceBundle().messageFormat(variables.$.rbKey('user.forgotnotvalid'),variables.$.event('email')))#<cfelseif FindNoCase('no account',msg2)><div class="#this.alertDangerClass#">#HTMLEditFormat(variables.$.siteConfig("rbFactory").getResourceBundle().messageFormat(variables.$.rbKey('user.forgotnotfound'),variables.$.event('email')))#<cfelse><div class="#this.alertSuccessClass#">#variables.$.rbKey('user.forgotsuccess')#</cfif></div>
						</cfif>
	
						<!--- Email --->
						<div class="#this.loginFormGroupWrapperClass#">
							<label class="#this.loginFormFieldLabelClass#" for="txtEmail">#variables.$.rbKey('user.email')#</label>
							<div class="#this.loginFormFieldWrapperClass#">
								<input id="txtEmail" name="email" class="#this.loginFormFieldClass#" type="text" placeholder="#variables.$.rbKey('user.email')#" validate="email" required="true" message="#htmlEditFormat(variables.$.rbKey('user.emailvalidate'))#" />
							</div>
						</div>
	
						<!--- Submit Button --->
						<div class="#this.loginFormGroupWrapperClass#">
							<div class="#this.loginFormSubmitWrapperClass#">
								<button type="submit" class="#this.loginFormSubmitClass#">#htmlEditFormat(variables.$.rbKey('user.getpassword'))#</button>
							</div>
						</div>
	
						<input type="hidden" name="doaction" value="sendlogin">
						<input type="hidden" name="linkServID" value="#HTMLEditFormat(variables.$.event('linkServID'))#">
						<input type="hidden" name="display" value="login">
						<input type="hidden" name="returnURL" value="#HTMLEditFormat(variables.$.event('returnURL'))#">
					</fieldset>
				</form>

				<!--- Not Registered? --->
				<cfif variables.$.siteConfig('ExtranetPublicReg')>
					<div id="notRegistered" class="mura-not-registered">
						<#variables.$.getHeaderTag('subHead1')# class="center">#variables.$.rbKey('user.notregistered')# <a class="#this.notRegisteredLinkClass#" href="#variables.$.siteConfig('editProfileURL')#&returnURL=#urlencodedformat(variables.$.event('returnURL'))#">#variables.$.rbKey('user.signup')#</a></#variables.$.getHeaderTag('subHead1')#>
					</div>
				</cfif>

				<script type="text/javascript">
				   document.getElementById("login").elements[0].focus();
				</script>
			</cfif>
		</div>
	</div>
</cfoutput>