@isTest
private class SandboxPostCopyUtlity_Test
{

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


	/** Check what happens when no users are enabled or disabled the system **/
	static testMethod void testSandboxNoUsersCopy()
	{
		SandboxPostCopyUtlity spcu = new SandboxPostCopyUtlity();
		// Given
			Test.testSandboxPostCopyScript(spcu,UserInfo.getOrganizationId(), UserInfo.getOrganizationId(), 'dev');
		// When
		//TODO:  Need to write assert logic
		// Then

	}

	/** Check what happens when no users are enabled or disabled the system **/
	static testMethod void testSandboxWithUsersCopy()
	{
		SandboxPostCopyUtlity spcu = new SandboxPostCopyUtlity();
		// Given
			Test.testSandboxPostCopyScript(spcu,UserInfo.getOrganizationId(), UserInfo.getOrganizationId(), 'dev');
		// When
		//TODO:  Need to write assert logic
		// Then

	}

	/** Check what happens when no users are enabled or disabled the system **/
	static testMethod void testSandboxWithoutSandboxName()
	{
		SandboxPostCopyUtlity spcu = new SandboxPostCopyUtlity();
		try {
			Test.testSandboxPostCopyScript(spcu,UserInfo.getOrganizationId(), UserInfo.getOrganizationId(), '');
		} catch (Exception ex){
			System.assertEquals('Sandbox Name is Empty', ex.getMessage());
		}



	}
}
