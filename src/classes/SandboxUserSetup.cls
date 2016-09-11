/*
*  Sandbox user Setup Class.  This class enables the users or disables the
* users.  This class also creates the users.
*  @author Kalyan Lanka
*/
public with sharing class SandboxUserSetup extends SandboxRefreshAbstract {

	Map<String,String> userNameEmailMap = new Map<String,String>();
	String userQuery = 'SELECT Id, isActive, Email, UserName FROM User ';
	List<User> updateUsers = new List<User>();
	List<User> createUsers = new List<User>();

	/* This method implements the run() for SandboxRefhresInterface.  This method
	executes the necessary business logic to process users after the sandbox
	refresh is complete
	@return void */
	public override void run() {
		String userList = setupUserList();
		disableUsers(userList);
		enableUsers(userList);
		createdUsers();

		Database.SaveResult[] saveResults = Database.update(updateUsers,false);
		for (Database.SaveResult sr : saveResults){
			//TODO:  Log all errors
		}
		saveResults = Database.insert(createUsers,false);
		for (Database.SaveResult sr : saveResults){
			//TODO:  Log all errors
		}

	}

	/* Helper method setups the User List to enable or disable.  The list of
	users are in the custom settings object Sandbox usres.  This method setups
	the user name in productionuserName.sandboxName format, that can be used
	to update the user in subsequent methods */
	private String setupUserList() {
		String sandboxOrgUserList = '';
		boolean isFirst = true;
		for (Sandbox_Users__c su : [SELECT Email__c,
																				Name
																FROM Sandbox_Users__c
																WHERE Operation__c='ENABLE'
																AND Is_Active__c = true]){
			userNameEmailMap.put(su.Name +  '.' + this.getSandboxName(),su.Email__c);
			sandboxOrgUserList += setupUserList(su.Name,isFirst);
			isFirst = false;
		}
		return sandboxOrgUserList;
	}


	/* Utility method that formats the user name for the query */
	private String setupUserList(String userName, Boolean isFirst) {

			if (!isFirst) {
				return (',' + '\'' + userName +  '.' + this.getSandboxName() + '\'');
			} else {
				return ('\'' + userName +  '.' + this.getSandboxName() + '\'');
			}

	}

	/*
	*   This method disables all users required to be in the sanddbox
	*/
	private void disableUsers(String userList) {

		//TODO:  Clean this up to something better.  This is when custom settings are not yet setup properly
		if (String.isBlank(userList)) {
			return;
		}

		String dynamicUserQuery = this.userQuery +
																				' WHERE Profile.Name != \'System Administrator\'' +
																				'	AND username NOT IN ('+ userList + ')';

		List<sObject> usersObject = Database.query(dynamicUserQuery);
		for (sObject u : usersObject){
			User usr = (User) u;
			if (usr.id != UserInfo.getUserID()){
				usr.isActive = false;
				updateUsers.add(usr);
			}
		}
	}

	/* This method enables the users that are only required to be available
	in the sandbox  */
	private void enableUsers(String userList) {

		//TODO:  Clean this up to something better.  This is when custom settings are not yet setup properly
		if (String.isBlank(userList)) {
			return;
		}
		
		String dynamicUserQuery = this.userQuery +
																				' WHERE username IN ('+ userList + ')';

		List<sObject> usersObject = Database.query(dynamicUserQuery);
		for (sObject u : usersObject){
			User usr = (User) u;
			usr.isActive = true;
			usr.Email = userNameEmailMap.get(usr.UserName);
			updateUsers.add(usr);
		}
	}

	/* This method creates new users that are needed */
 public void createdUsers() {
	 Map<String,Id> profileMap = new Map<String,ID>();
	 for (Profile p : [SELECT Id, Name FROM Profile]){
		 profileMap.put(p.Name,p.id);
	 }

	 for (Sandbox_Users__c su : [SELECT Email__c,
	 																	Name,
																		License__c,
																		Operation__c,
																		Profile_Name__c,
																		First_Name__c,
																		Last_Name__c,
																		Alias__c,
																		Timezone__c,
																		Encoding_Key__c
														  FROM Sandbox_Users__c
															WHERE Operation__c='CREATE'
															AND Is_Active__c = true]){
			String userName = su.Name + '.' + this.getSandboxName();

			createUsers.add(new User(FirstName=su.First_Name__c,LastName=su.Last_Name__c,Alias=su.Alias__c,
												Email=su.Name,
												username=userName,isActive=true,
												LanguageLocaleKey='en_US', LocaleSidKey='en_US',
												TimeZoneSidKey=su.Timezone__c,ProfileId = profileMap.get(su.Profile_Name__c),
												EmailEncodingKey=su.Encoding_Key__c));



	 }

 }

	/* return this class name */
	public String getClassName() {
		return 'SandboxUserSetup';
	}

}
