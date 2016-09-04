/*
* The Sandbox refresh Interface handels Apex Classes for Sandbox Refresh
* @author Kalyan Lanka
*/
public interface SandboxRefreshInterface {

	/*
	*  Get the sandbox Name
	*/
	String getSandboxName();

	/*
	*  Get the sandbox ID
	*/
	String getSandboxID();

	/*
	*  Get the Organization ID
	*/
	String getOrganizationID();

	/*
	*  This method executes the sandbox Class
	*/
	void run();

	/*
	*  Get the class name.  Every class should implement this method
	*/
	String getClassName();

}
