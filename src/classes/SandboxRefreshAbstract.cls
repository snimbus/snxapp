/** This is an abstract class for Sandbox Refresh Logic **/
public with sharing abstract class SandboxRefreshAbstract implements SandboxRefreshInterface {

	String sandboxID {get;set;}
	String sandboxName {get;set;}
	String organizationID {get;set;}

	public SandboxRefreshAbstract(SandboxContext context){
		this.sandboxID = context.sandboxId();
		this.sandboxName = context.sandboxName();
		this.organizationID = context.organizationId();
	}

	public SandboxRefreshAbstract(String sandboxID, String sandboxName, String orgainizationID) {
		this.sandboxID = sandboxID;
		this.sandboxName = sandboxName;
		this.organizationID = organizationID;
	}

	public virtual String getSandboxName() {
		return this.sandboxName;
	}

	public virtual Id getSandboxID() {
		return this.sandboxID;
	}

	public Id getOrganizationID() {
		return this.sandboxID;
	}

	public virtual void run() {

	}

	public virtual String getClassName() {
		return 'SandboxRefreshAbstract';
	}

}
