component accessors="true" {
	property name="accessToken" type="string" default="";

	property name="target" type="string";
	property name="state" type="string";
	property name="api" type="FacebookAPI";

	public void function init(FacebookAPI api) {
		setApi(arguments.api);

		setState(hash(createUUID()));
	}

	public string function connect(string target) {
		setTarget(arguments.target);
		
		return getApi().getDialogUrl().build({state: getState()});
	}

	public boolean function oauth(string code, string state) {
		if (arguments.state == getState()) {
			var r = {};
			var tokenUrl = getApi().getTokenUrl();
			
			http url="#tokenUrl.build({code: arguments.code})#" result="r";
			
			var qs = tokenUrl.deserializeQueryString(r.filecontent);

			if (qs.keyExists("access_token")) {
				setAccessToken(qs["access_token"]);
				setState("");
				
				//echo("redirect to <a href='" & getTarget() & "'>" & getTarget() & "</a>");
				//dump(me);
				return true;
			} else {
				// This is an error case.
				dump(r);abort;
				// return r?
			}
		}
		return false;
	}

	public struct function graph(string resource) {
		var r = "";

		http url="#getApi().getGraphUrl().build({access_token=getAccessToken()}, arguments.resource)#" result="r";
		
		return deserializeJSON(r.filecontent);
	}

	public string function getTarget() {
		// todo: change this to Mura current site home page
		// should be done outside this component
		return (variables.target == "")?"http://#cgi.script_name#":variables.target;
	}

}