component accessors="true" {
	property name="protocol" type="string";
	property name="domain" type="string";
	property name="resource" type="string";
	property name="fields" type="struct";
	
	public URLHelper function init(string domain = "", string resource = "", struct fields = {}, string protocol = "http") {
		setDomain(arguments.domain);
		setResource(arguments.resource);
		setFields(arguments.fields);
		setProtocol(arguments.protocol);

		return this;
	}

	public string function build(struct additionalFields = {}, string resource) {
		
		if (!isDefined("arguments.resource")) arguments.resource = getResource();
		
		return getProtocol() & "://"
			& getDomain()
			& arguments.resource
			& serializeQueryString(additionalFields.append(getFields()));

	}

	public string function serializeQueryString(struct fields) {
		var queryString = "";
		for (var v in fields) {
			queryString &= ((queryString == "")?"?":"&") & lcase(v) & "=" & urlEncode(fields[v]);
		}

		return queryString;

	}

	public struct function deserializeQueryString(string queryString) {
		var fields = {};

		var fieldsArray = listToArray(listLast(arguments.queryString, "?"), "&");		
		fieldsArray.each(function(string field) {
			fields[listFirst(field, "=")] = urlDecode(listLast(field, "="));
		});

		return fields;
		
	}

}