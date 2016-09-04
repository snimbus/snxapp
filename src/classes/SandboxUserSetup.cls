public with sharing class SandboxUserSetup extends SandboxRefreshAbstract {
	public String enabledUserList = '{"enabledUsers": [{"userName":"asfsa@asdfsdf.com"},{"userName":"dfdf@asdfsdf.com"},{"userName":"dfd@asdfsdf.com"}]}';
	public String createdUserStr = '{"createUsers":[{"userName":"adsfsdf@asdfsf.com","emailAddress":"adfasdf@asdfsd.com","isActive":"true","isMarketingUser":false,"ProfileName":"System Administrator"},{"userName":"adsfsdf@asdfsf.com","emailAddress":"adfasdf@asdfsd.com","isActive":"true","isMarketingUser":false,"ProfileName":"System Administrator"}]}';
	public EnabledUsersList enabledUsers {get;set;}
	public CreateUserList createdUserList {get;set;}
	String userQuery = 'SELECT Id, isActive, Email FROM User';
	List<sObject> userObjectList {get;set;}

	public SandboxUserSetup() {
		super('12312dfsdfsd','dev','123123123');
		this.enabledUsers = (EnabledUsersList) JSON.deserializeStrict(enabledUserList,EnabledUsersList.class);
		this.createdUserList = (CreateUserList) JSON.deserializeStrict(createdUserStr,CreateUserList.class);
		System.debug(enabledUsers);
		System.debug(createdUserList);
	}

	public SandboxUserSetup(SandboxContext context) {
		super(context);
	}

	public override void run() {
		String userList = setupUserList();
		disableUsers(userList);
		enableUsers(userList);
		createdUsers();

		update userObjectList;
	}

	private String setupUserList() {
		String sandboxOrgUserList = '';
		for (EnabledUser eu : enabledUsers.enabledUsers){
			sandboxOrgUserList += ',' + '\'' + eu.userName +  '.' + this.getSandboxName() + '\'';
		}
		return sandboxOrgUserList;
	}

	/*
	*   This method disables all users who are not required to be in the sanddbox
	*/
	private void disableUsers(String userList) {
		userObjectList.addAll(Database.query(this.userQuery + ' WHERE username NOT IN ' + userList));
		for (sObject u : userObjectList){
			User usr = (User) u;
			usr.isActive = false;
		}

	}

	/* This method enables the users that are only required to be available in the sandbox  */
	private void enableUsers(String userList) {
		userObjectList.addAll(Database.query(this.userQuery + ' WHERE username ' + userList));
		for (sObject u : userObjectList){
			User usr = (User) u;
			usr.isActive = true;
			usr.Email = resetEmailAddrses(usr.EMail);
		}
	}

	private String resetEmailAddrses(String emailAddress) {
		if (String.isNotBlank(emailAddress)){
			emailAddress = emailAddress.replace('@example.com','');
			emailAddress = emailAddress.replace('=','@');
		}
		return emailAddress;
	}

	/* This method creates new users that are needed */
 public void createdUsers() {

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

 public class CrateUser {
		 public String userName {get;set;}
		 public String emailAddress {get;set;}
		 public Boolean isActive {get;set;}
		 public Boolean isMarketingUser {get;set;}
		 public String ProfileName {get;set;}


 }

 public class CreateUserList {
	 public List<CrateUser> createUsers {get;set;}
 }

}