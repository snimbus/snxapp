/*
*  This is a Utlity Class that is called when Sandbox Copy is refreshed
* @author Kalyan Lanka
*/
public with sharing class SandboxPostCopyUtlity implements SandboxPostCopy {


/** Implement the run class interface for post sandbox copy **/
	public void runApexClass(SandboxContext sc){
		System.debug('Inside runApex Class');
		System.debug(sc);
		String sandboxName = sc.sandboxName();

		if (String.isBlank(sandboxName)){
			throw new SandboxPostCopyUtlityException('Sandbox Name is Empty');
		}

		for (Sandbox_Refresh__mdt sandboxRefreshMetadata : [SELECT ID,
																	DeveloperName,
																	MasterLabel,
																	NamespacePrefix,
																	Is_Active__c,
																	Order_of_Execution__c,
																	Run_In_All_Sandboxes__c,
																	Sandbox_Name__c
																	FROM Sandbox_Refresh__mdt
																	WHERE Is_Active__c = true
																	ORDER BY Order_of_Execution__c ASC]){
				System.debug(sandboxRefreshMetadata);

				if (sandboxRefreshMetadata.Run_In_All_Sandboxes__c ||
					 (String.isNotBlank(sandboxRefreshMetadata.Sandbox_Name__c) &&
							sandboxRefreshMetadata.Sandbox_Name__c.contains(sandboxName))) {
					Type classType = Type.forName(sandboxRefreshMetadata.DeveloperName);
					SandboxRefreshAbstract sra = (SandboxRefreshAbstract) classType.newInstance();
					sra.setContext(sc);
					sra.run();
				}
		}
	}
}
