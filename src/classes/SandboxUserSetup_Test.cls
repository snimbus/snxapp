/*
*  This is a sanddbox user setup test class
*  @author Kalyan Lanka
*/
@isTest
private class SandboxUserSetup_Test {

	/* Setup initial test data */
	@testSetup
	static void setUpData() {
		//Create Users
		List<User> users = new List<User>();
		Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
		users.add(new User(FirstName='Bob',LastName='Smith',Alias='bsi2347',
											Email='bob.smith=universalcontainers.com@example.com.dev',
											username='bob.smith@universalcontainers.com.dev',isActive=true,
											LanguageLocaleKey='en_US', LocaleSidKey='en_US',
											TimeZoneSidKey='America/New_York',ProfileId = p.Id,
											EmailEncodingKey='UTF-8'));
		users.add(new User(FirstName='Mary',LastName='Smith',Alias='mi247',
											Email='Mary.smith=universalcontainers.com@example.com',
											username='Mary.smith@universalcontainers.com.dev',isActive=true,
											LanguageLocaleKey='en_US', LocaleSidKey='en_US',
											TimeZoneSidKey='America/New_York',ProfileId = p.Id,
											EmailEncodingKey='UTF-8'));
		users.add(new User(FirstName='Joe',LastName='Smith',Alias='jdmi247',
											Email='Joe.smith=universalcontainers.com@example.com',
											username='Joe.smith@universalcontainers.com.dev',isActive=true,
											LanguageLocaleKey='en_US', LocaleSidKey='en_US',
											TimeZoneSidKey='America/New_York',ProfileId = p.Id,
											EmailEncodingKey='UTF-8'));

		insert users;

		List<Sandbox_Users__c> sandboxUsers = new List<Sandbox_Users__c>();
		sandboxUsers.add(new Sandbox_Users__c(name='bob.smith@universalcontainers.com',
										Email__c='bob.smith@universalcontainers.com',Is_Active__c=true,
										Operation__c='ENABLE'));

		sandboxUsers.add(new Sandbox_Users__c(name='mary.smith@universalcontainers.com',
																		Email__c='mary.smith@universalcontainers.com',
																		Is_Active__c=true,
																		Operation__c='ENABLE'));
		sandboxUsers.add(new Sandbox_Users__c(name='james.smith@universalcontainers.com',
																		Email__c='james.smith@universalcontainers.com',
																		Is_Active__c=true,First_Name__c='James',
																		Last_Name__c='Smith',
																		Alias__c='Smith&*&',
																		Timezone__c='America/New_York',
																		Encoding_Key__c='UTF-8',
																		Profile_Name__c='Standard User',
																		Operation__c='CREATE'));

		insert sandboxUsers;


	}

	/* Check for fixing the email address, disabling users and also create new users */
	static testMethod void itShouldEnableAndDisableUsers() {
		// Given
		SandboxUserSetup sra = new SandboxUserSetup();
		// When
		sra.setOrganizationID('My Org ID');
		sra.setSandboxID('My Sandbox ID');
		sra.setSandboxName('dev');
		sra.run();
		// Then
		// The user should be inactivated
		System.assertEquals(false,[SELECT IsActive FROM User
															WHERE username = 'joe.smith@universalcontainers.com.dev'
															LIMIT 1].IsActive);
	  //The user email address should be updated
		System.assertEquals('mary.smith@universalcontainers.com',[SELECT Email FROM User
															WHERE username = 'mary.smith@universalcontainers.com.dev'
															LIMIT 1].Email);
		//The user email address should be created
		System.assertEquals('bob.smith@universalcontainers.com',[SELECT Email FROM User
															WHERE username = 'bob.smith@universalcontainers.com.dev'
															LIMIT 1].Email);
	}

/* Check to see if SandboxContext variables are returned properly */
	static testMethod void itShouldReturnContextVariables() {
		// Given
		SandboxUserSetup sra = new SandboxUserSetup();
		// When
		sra.setOrganizationID('My Org ID');
		sra.setSandboxID('My Sandbox ID');
		sra.setSandboxName('dev');
		// Then
		System.assertEquals('My Org ID',sra.getOrganizationID());
		System.assertEquals('My Sandbox ID',sra.getSandboxID());
		System.assertEquals('dev',sra.getSandboxName());
		System.assertEquals('SandboxUserSetup',sra.getClassName());
	}

}
