component accessors='true' {

	property name='$';
	property name='pluginConfig';

	public SocialLoginService function init(muraScope $, pluginConfig pc) {
		set$(arguments.$);
		setPluginConfig(arguments.pc);

		return this;
	}

	public void function login(struct me, string groups='') {
		var user = $.getBean('User').loadBy(remoteID=arguments.me.id);

		// even if the user exists, we update information at login
		user.setRemoteID(arguments.me.id);
		user.setSiteID(session.siteID);
		user.setUsername('fb-' & arguments.me.username & '-' & arguments.me.id);
		user.setSubType("Social Login");
		user.setEmail(arguments.me.email);
		user.setFname(arguments.me.first_name);
		user.setLname(arguments.me.last_name);
	
		for (var groupname in listToArray(arguments.groups)) {
			var group=$.getBean('user').loadBy(groupname=groupname,siteid=session.siteID);
			if (group.getIsNew()) { // create group if doesn't exist
				group.setSiteID(session.siteID).setType(1).setGroupName(groupname).setIsPublic(1).save();
			}
			user.setGroupID(groupID=$.getBean('user').loadBy(groupname=groupname).getUserID(),append=false);
		}
		user.save();

		$.getBean('UserUtility').loginByUserID(user.getUserID(), user.getSiteID());
	}

}