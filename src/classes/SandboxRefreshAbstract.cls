/*
*  This is an abstract class for Sandbox Refresh Logic
* @author Kalyan Lanka
*/
public abstract class SandboxRefreshAbstract
														implements SandboxRefreshInterface {

	private String sandboxName;
	private String sandboxId;
	private String organizationId;

	/* Set Sandbox Name */
	public virtual void setSandboxName(String sandboxName) {
		this.sandboxName = sandboxName;
	}

	/* Set Sandbox ID */
	public virtual void setSandboxID(String sandboxId) {
		this.sandboxId = sandboxId;
	}

	/* Set Organization */
	public virtual void  setOrganizationID(String organizationID) {
		this.organizationId = organizationID;
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
