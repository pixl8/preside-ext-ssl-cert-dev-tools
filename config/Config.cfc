component {

	public void function configure( required struct config ) {
		// core settings that will effect Preside
		var settings = arguments.config.settings ?: {};

		settings.features[ "devtools.sslcert" ] = { enabled=true , siteTemplates=[ "*" ], widgets=[] }

	}
}