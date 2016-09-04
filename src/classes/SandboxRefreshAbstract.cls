/*
*  This is an abstract class for Sandbox Refresh Logic
* @author Kalyan Lanka
*/
public with sharing abstract class SandboxRefreshAbstract
														implements SandboxRefreshInterface {

	String sandboxID {get;set;}
	String sandboxName {get;set;}
	String organizationID {get;set;}

	/* Constructor with Sandbox Context */
	public SandboxRefreshAbstract(SandboxContext context){
		this.sandboxID = context.sandboxId();
		this.sandboxName = context.sandboxName();
		this.organizationID = context.organizationId();
	}

	/* Constructor with Sadnbox details that are already passed..
	This may be useful for testing */
	public SandboxRefreshAbstract(String sandboxID,
																String sandboxName,
																String orgainizationID) {
		this.sandboxID = sandboxID;
		this.sandboxName = sandboxName;
		this.organizationID = organizationID;
	}

	/* Get Sandbox Name */
	public virtual String getSandboxName() {
		return this.sandboxName;
	}

	/* Get Sandbox ID */
	public virtual Id getSandboxID() {
		return this.sandboxID;
	}

	/* Get Organization */
	public Id getOrganizationID() {
		return this.sandboxID;
	}

	/* Implement this method to process the business logic */
	public virtual void run() {
		throw new SandboxRefreshAbstractException('Need to implement run() Method');
	}

	/* Implement this method to getClassName */
	public virtual String getClassName() {
		throw new SandboxRefreshAbstractException('Need to implement getClassName() Method');
	}

}