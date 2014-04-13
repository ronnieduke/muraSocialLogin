component accessors="true" {
	property name="version" type="string" default="0.0.1";

	property name="id" type="string";
	property name="secret" type="string";
	property name="scope" type="string";
	
	property name="base" type="string";
	property name="domains" type="struct";
	property name="dialogUrl" type="URLHelper";
	property name="tokenUrl" type="URLHelper";
	property name="graphUrl" type="URLHelper";

	public void function init(string id, string secret, string scope = "") {
		setId(arguments.id);
		setSecret(arguments.secret);
		setScope(arguments.scope);

		setDomains({www:"www.facebook.com", graph:"graph.facebook.com"});

		// For Windows, we need to convert '\' in '/'
		var templatePath = REReplace(getBaseTemplatePath(), "\\", "/", "all");
		var path = REReplace(templatePath, cgi.script_name & "$", "");
		templatePath = REReplace(getCurrentTemplatePath(), "\\", "/", "all");
		path = (REReplace(templatePath, "^" & path, ""));
		var base = REReplace(cgi.request_url, cgi.script_name & ".*$", "");
		setBase(base & getDirectoryFromPath(path));

		// using this syntax for createObject to be sure to retrieve component relatively to this one
		setDialogUrl(createObject("component", "../utils/URLHelper").init(
			getDomain("www"),
			"/dialog/oauth",
			{
				client_id: getId(),
				redirect_uri: getBase("oauth.cfm"),
				scope: getScope()
			}
		));

		setTokenUrl(createObject("component", "../utils/URLHelper").init(
			getDomain("graph"),
			"/oauth/access_token",
			{
				client_id: getId(),
				client_secret: variables.secret,
				redirect_uri: getBase("oauth.cfm")
			},
			"https"
		));

		setGraphUrl(createObject("component", "../utils/URLHelper").init(
			getDomain("graph"), "", {}, "https"
		));

	}

	public FacebookSession function getCurrentSession(boolean reset = false) {
		if (reset or !session.keyExists("fbsession")) {
			session.fbsession = new FacebookSession(this);
		}

		return session.fbsession;
	}

	public string function getDomain(string domain) {
		return getDomains()[arguments.domain];
	}

	public string function getBase(string uri = "") {
		return variables.base & arguments.uri;
	}

}