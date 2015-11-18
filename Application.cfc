<!-----------------------------------------------------------------------
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Date        :	10/16/2007
Description :
	This is the bootstrapper Application.cfc for ColdBox Applications.
	It uses inheritance on the CFC, so if you do not want inheritance
	then use the Application_noinheritance.cfc instead.


----------------------------------------------------------------------->
<cfcomponent extends="coldbox.system.Coldbox" output="false">
	<cfsetting enablecfoutputonly="yes">
	<!--- APPLICATION CFC PROPERTIES --->

	<cfscript>
		this.name = "ci-test@"&hash(getCurrentTemplatePath());		
    </cfscript>

	<!--- COLDBOX STATIC PROPERTY, DO NOT CHANGE UNLESS THIS IS NOT THE ROOT OF YOUR COLDBOX APP --->
	<cfset COLDBOX_APP_ROOT_PATH = getDirectoryFromPath(getCurrentTemplatePath())>
	<!--- The web server mapping to this application. Used for remote purposes or static purposes --->
	<cfset COLDBOX_APP_MAPPING   = "">
	<!--- COLDBOX PROPERTIES --->
	<cfset COLDBOX_CONFIG_FILE   = "">
	<!--- COLDBOX APPLICATION KEY OVERRIDE --->
	<cfset COLDBOX_APP_KEY       = "">

	<!--- on Application Start --->
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfscript>
			var ret =  super.onApplicationStart();
			return ret;
		</cfscript>
	</cffunction>

	<!--- on Request Start --->
	<cffunction name="onRequestStart" returnType="boolean" output="true">
		<!--- ************************************************************* --->
		<cfargument name="targetPage" type="string" required="true" />
		<!--- ************************************************************* --->

		<!--- Process A ColdBox Request Only --->
		<cfif findNoCase('index.cfm', listLast(arguments.targetPage, '/'))>

			<cfif structKeyExists(url,"fwreinit")>
				<cfsetting requesttimeout="600">
			<cfelse><!--- if we are not reiniting --->
				<cfif (not structKeyExists(application,"cbcontroller")) or (application.cbcontroller.getcoldboxinitiated()  eq false)>
					<!--- if cbcontroller has not been put into app scope of returns false, then show server as busy --->
					<cfheader statuscode="500" statustext="Server Busy">
					<cfoutput>Server Busy</cfoutput>
					<cfabort>
				</cfif>
			</cfif>

			<!--- Reload Checks --->
			<cfset reloadChecks()>
	
			<!--- Process Request --->
			<cfset processColdBoxRequest()>
		</cfif>

		<!--- WHATEVER YOU WANT BELOW --->
		<cfreturn true>
	</cffunction>
</cfcomponent>