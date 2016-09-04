/*
*  This is an abstract class for Sandbox Refresh Logic
* @author Kalyan Lanka
*/
public with sharing abstract class SandboxRefreshAbstract
														implements SandboxRefreshInterface {

	SandboxContext context;
	
	public virtual SandboxContext getContext() {
		return this.context;
	}

	/* Get Sandbox Name */
	public virtual String getSandboxName() {
		return this.context.sandboxName();
	}

	/* Get Sandbox ID */
	public virtual Id getSandboxID() {
		return this.context.sandboxId();
	}

	/* Get Organization */
	public Id getOrganizationID() {
		return this.context.organizationId();
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
