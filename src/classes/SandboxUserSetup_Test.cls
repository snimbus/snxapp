@isTest
private class SandboxUserSetup_Test
{
	@isTest
	static void itShouldReturnContextVariables()
	{
		// Given
		SandboxUserSetup sra = new SandboxUserSetup();
		// When
		sra.setOrganizationID('My Org ID');
		sra.setSandboxID('My Sandbox ID');
		sra.setSandboxName('My Sandbox Name');
		// Then
		System.assertEquals('My Org ID',sra.getOrganizationID());
		System.assertEquals('My Sandbox ID',sra.getSandboxID());
		System.assertEquals('My Sandbox Name',sra.getSandboxName());
		System.assertEquals('SandboxUserSetup',sra.getClassName());
	}

	@isTest
	static void itShouldUpdateUsers()
	{
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
