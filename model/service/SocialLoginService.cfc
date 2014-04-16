component accessors='true' {

	property name='$';
	property name='pluginConfig';

	public SocialLoginService function init(muraScope $, pluginConfig pc) {
		set$(arguments.$);
		setPluginConfig(arguments.pc);

		return this;
	}

	public void function login(struct me, string groups='') {
		var user = get$().getBean('User').loadBy(remoteID=arguments.me.id);

		// even if the user exists, we update information at login
		if (user.getIsNew() or variables.pluginConfig.getSetting('socialKeepSync')) {
			user.setRemoteID(arguments.me.id);
			user.setSiteID(session.siteID);
			user.setUsername('fb-' & arguments.me.username & '-' & arguments.me.id);
			user.setSubType("Social Login");
			user.setEmail(arguments.me.email);
			user.setFname(arguments.me.first_name);
			user.setLname(arguments.me.last_name);
	
			for (var groupname in listToArray(arguments.groups)) {
				var group=get$().getBean('user').loadBy(groupname=groupname,siteid=session.siteID);
				if (group.getIsNew()) { // create group if doesn't exist
					group.setSiteID(session.siteID).setType(1).setGroupName(groupname).setIsPublic(1).save();
				}
				user.setGroupID(groupID=get$().getBean('user').loadBy(groupname=groupname).getUserID(),append=false);
			}
			user.save();
		}

		get$().getBean('UserUtility').loginByUserID(user.getUserID(), user.getSiteID());
	}

}