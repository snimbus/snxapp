/*
*  This is an abstract class for Sandbox Refresh Logic
* @author Kalyan Lanka
*/
public abstract class SandboxRefreshAbstract
														implements SandboxRefreshInterface {

	private String sandboxName;
	private String sandboxId;
	private String organizationId;
	SandboxContext context;

	/** Do Nothing run method **/
	public virtual void run() {

	}

	/** Set Sandbox Context **/
	public virtual void setContext(SandboxContext context) {
		this.context = context;
		this.sandboxName  = context.sandboxName();
		this.sandboxId  = context.sandboxId();
		this.organizationId  = context.organizationId();

	}
	/* Get Sandbox Name */
	public virtual String getSandboxName() {
		return this.sandboxName;
	}

	/* Get Sandbox ID */
	public virtual String getSandboxID() {
		return this.sandboxId;
	}

	/* Get Organization */
	public virtual String getOrganizationID() {
		return this.organizationId;
	}

}
