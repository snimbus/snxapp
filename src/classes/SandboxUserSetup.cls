public with sharing class SandboxUserSetup extends SandboxRefreshAbstract {
	public String enabledUserList = '{"enabledUsers": [{"userName":"asfsa@asdfsdf.com"},{"userName":"dfdf@asdfsdf.com"},{"userName":"dfd@asdfsdf.com"}]}';

	public SandboxUserSetup() {
		super('12312dfsdfsd','dev','123123123');
		EnabledUsersList enabledUsers = (EnabledUsersList) JSON.deserializeStrict(enabledUserList,EnabledUsersList.class);
		System.debug(enabledUsers);
	}
	public SandboxUserSetup(SandboxContext context) {
		super(context);
	}



	public override void run() {
		//Get the List of the users to Setup

		disableUsers();
		enableUsers();
		createUsers();
	}

	/*
	*   This method disables all users who are not required to be in the sanddbox
	*/
	private void disableUsers() {
		//Assume this is sthe Setu
		//Read JSON



	}

	/* This method enables the users that are only required to be available in the sandbox  */
	private void enableUsers() {

	}

	/* This method creates new users that are needed */
	private void createUsers() {

	}

	/* return this class name */
	public override String getClassName() {
		return 'SandboxUserSetup';
	}

	public class EnabledUser {
			public String userName {get;set;}
	}

 public class EnabledUsersList {
		public List<EnabledUser> enabledUsers {get;set;}
	}
}
