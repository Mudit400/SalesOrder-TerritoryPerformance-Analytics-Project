@secure()
param vulnerabilityAssessments_Default_storageContainerPath string
param workspaces_aw_project_adb_name string = 'aw-project-adb'
param workspaces_awproject11_synapse_name string = 'awproject11-synapse'
param storageAccounts_synapsestorageaw_name string = 'synapsestorageaw'
param storageAccounts_adlsgen2adventure11_name string = 'adlsgen2adventure11'

resource workspaces_aw_project_adb_name_resource 'Microsoft.Databricks/workspaces@2026-01-01' = {
  name: workspaces_aw_project_adb_name
  location: 'eastus'
  sku: {
    name: 'trial'
  }
  properties: {
    computeMode: 'Hybrid'
    defaultCatalog: {
      initialType: 'UnityCatalog'
    }
    managedResourceGroupId: '/subscriptions/90800478-a6e6-4fa5-950c-b290158791d3/resourceGroups/managed-adb-awproject'
    parameters: {
      enableNoPublicIp: {
        type: 'Bool'
        value: true
      }
      natGatewayName: {
        type: 'String'
        value: 'nat-gateway'
      }
      prepareEncryption: {
        type: 'Bool'
        value: false
      }
      publicIpName: {
        type: 'String'
        value: 'nat-gw-public-ip'
      }
      requireInfrastructureEncryption: {
        type: 'Bool'
        value: false
      }
      storageAccountName: {
        type: 'String'
        value: 'dbstorageutnwlc6zpzkwk'
      }
      storageAccountSkuName: {
        type: 'String'
        value: 'Standard_ZRS'
      }
      vnetAddressPrefix: {
        type: 'String'
        value: '10.139'
      }
    }
    authorizations: [
      {
        principalId: '9a74af6f-d153-4348-988a-e2672920bee9'
        roleDefinitionId: '8e3af657-a8ff-443c-a75c-2fe8c4bcb635'
      }
    ]
    createdBy: {}
    updatedBy: {}
  }
}

resource storageAccounts_adlsgen2adventure11_name_resource 'Microsoft.Storage/storageAccounts@2026-06-01' = {
  name: storageAccounts_adlsgen2adventure11_name
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    allowCrossTenantDelegationSas: false
    dualStackEndpointPreference: {
      publishIpv6Endpoint: false
    }
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    isHnsEnabled: true
    networkAcls: {
      ipv6Rules: []
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource storageAccounts_synapsestorageaw_name_resource 'Microsoft.Storage/storageAccounts@2026-06-01' = {
  name: storageAccounts_synapsestorageaw_name
  location: 'eastus'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    allowCrossTenantDelegationSas: false
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    isHnsEnabled: true
    networkAcls: {
      ipv6Rules: []
      bypass: 'None'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource storageAccounts_adlsgen2adventure11_name_default 'Microsoft.Storage/storageAccounts/blobServices@2026-06-01' = {
  parent: storageAccounts_adlsgen2adventure11_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    staticWebsite: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 7
    }
  }
}

resource storageAccounts_synapsestorageaw_name_default 'Microsoft.Storage/storageAccounts/blobServices@2026-06-01' = {
  parent: storageAccounts_synapsestorageaw_name_resource
  name: 'default'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  properties: {
    staticWebsite: {
      enabled: false
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_adlsgen2adventure11_name_default 'Microsoft.Storage/storageAccounts/fileServices@2026-06-01' = {
  parent: storageAccounts_adlsgen2adventure11_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {
        encryptionInTransit: {
          required: true
        }
      }
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_synapsestorageaw_name_default 'Microsoft.Storage/storageAccounts/fileServices@2026-06-01' = {
  parent: storageAccounts_synapsestorageaw_name_resource
  name: 'default'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_adlsgen2adventure11_name_default 'Microsoft.Storage/storageAccounts/queueServices@2026-06-01' = {
  parent: storageAccounts_adlsgen2adventure11_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_synapsestorageaw_name_default 'Microsoft.Storage/storageAccounts/queueServices@2026-06-01' = {
  parent: storageAccounts_synapsestorageaw_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_adlsgen2adventure11_name_default 'Microsoft.Storage/storageAccounts/tableServices@2026-06-01' = {
  parent: storageAccounts_adlsgen2adventure11_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_synapsestorageaw_name_default 'Microsoft.Storage/storageAccounts/tableServices@2026-06-01' = {
  parent: storageAccounts_synapsestorageaw_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource workspaces_awproject11_synapse_name_resource 'Microsoft.Synapse/workspaces@2021-06-01' = {
  name: workspaces_awproject11_synapse_name
  location: 'centralindia'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    defaultDataLakeStorage: {
      resourceId: storageAccounts_synapsestorageaw_name_resource.id
      createManagedPrivateEndpoint: false
      accountUrl: 'https://synapsestorageaw.dfs.core.windows.net'
      filesystem: 'defaultfilesystemaw'
    }
    encryption: {}
    managedResourceGroupName: 'managed-synapse'
    sqlAdministratorLogin: 'sqladminuser'
    privateEndpointConnections: []
    publicNetworkAccess: 'Enabled'
    cspWorkspaceAdminProperties: {
      initialWorkspaceAdminObjectId: '80086224-44d9-4128-9679-ad9b3390b1ee'
    }
    azureADOnlyAuthentication: false
    trustedServiceBypassEnabled: false
  }
}

resource workspaces_awproject11_synapse_name_Default 'Microsoft.Synapse/workspaces/auditingSettings@2021-06-01' = {
  parent: workspaces_awproject11_synapse_name_resource
  name: 'Default'
  properties: {
    retentionDays: 0
    auditActionsAndGroups: []
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource Microsoft_Synapse_workspaces_azureADOnlyAuthentications_workspaces_awproject11_synapse_name_default 'Microsoft.Synapse/workspaces/azureADOnlyAuthentications@2021-06-01' = {
  parent: workspaces_awproject11_synapse_name_resource
  name: 'default'
  properties: {
    azureADOnlyAuthentication: false
  }
}

resource Microsoft_Synapse_workspaces_dedicatedSQLminimalTlsSettings_workspaces_awproject11_synapse_name_default 'Microsoft.Synapse/workspaces/dedicatedSQLminimalTlsSettings@2021-06-01' = {
  parent: workspaces_awproject11_synapse_name_resource
  name: 'default'
  location: 'centralindia'
  properties: {
    minimalTlsVersion: '1.2'
  }
}

resource Microsoft_Synapse_workspaces_extendedAuditingSettings_workspaces_awproject11_synapse_name_Default 'Microsoft.Synapse/workspaces/extendedAuditingSettings@2021-06-01' = {
  parent: workspaces_awproject11_synapse_name_resource
  name: 'Default'
  properties: {
    retentionDays: 0
    auditActionsAndGroups: []
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource workspaces_awproject11_synapse_name_allowAll 'Microsoft.Synapse/workspaces/firewallRules@2021-06-01' = {
  parent: workspaces_awproject11_synapse_name_resource
  name: 'allowAll'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '255.255.255.255'
  }
}

resource workspaces_awproject11_synapse_name_AutoResolveIntegrationRuntime 'Microsoft.Synapse/workspaces/integrationruntimes@2021-06-01' = {
  parent: workspaces_awproject11_synapse_name_resource
  name: 'AutoResolveIntegrationRuntime'
  properties: {
    type: 'Managed'
    typeProperties: {
      computeProperties: {
        location: 'AutoResolve'
      }
    }
  }
}

resource Microsoft_Synapse_workspaces_securityAlertPolicies_workspaces_awproject11_synapse_name_Default 'Microsoft.Synapse/workspaces/securityAlertPolicies@2021-06-01' = {
  parent: workspaces_awproject11_synapse_name_resource
  name: 'Default'
  properties: {
    state: 'Disabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
}

resource Microsoft_Synapse_workspaces_vulnerabilityAssessments_workspaces_awproject11_synapse_name_Default 'Microsoft.Synapse/workspaces/vulnerabilityAssessments@2021-06-01' = {
  parent: workspaces_awproject11_synapse_name_resource
  name: 'Default'
  properties: {
    recurringScans: {
      isEnabled: false
      emailSubscriptionAdmins: true
    }
    storageContainerPath: vulnerabilityAssessments_Default_storageContainerPath
  }
}

resource storageAccounts_adlsgen2adventure11_name_default_bronze 'Microsoft.Storage/storageAccounts/blobServices/containers@2026-06-01' = {
  parent: storageAccounts_adlsgen2adventure11_name_default
  name: 'bronze'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_adlsgen2adventure11_name_resource
  ]
}

resource storageAccounts_synapsestorageaw_name_default_defaultfilesystemaw 'Microsoft.Storage/storageAccounts/blobServices/containers@2026-06-01' = {
  parent: storageAccounts_synapsestorageaw_name_default
  name: 'defaultfilesystemaw'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_synapsestorageaw_name_resource
  ]
}

resource storageAccounts_adlsgen2adventure11_name_default_gold 'Microsoft.Storage/storageAccounts/blobServices/containers@2026-06-01' = {
  parent: storageAccounts_adlsgen2adventure11_name_default
  name: 'gold'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_adlsgen2adventure11_name_resource
  ]
}

resource storageAccounts_adlsgen2adventure11_name_default_parameters 'Microsoft.Storage/storageAccounts/blobServices/containers@2026-06-01' = {
  parent: storageAccounts_adlsgen2adventure11_name_default
  name: 'parameters'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_adlsgen2adventure11_name_resource
  ]
}

resource storageAccounts_adlsgen2adventure11_name_default_silver 'Microsoft.Storage/storageAccounts/blobServices/containers@2026-06-01' = {
  parent: storageAccounts_adlsgen2adventure11_name_default
  name: 'silver'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_adlsgen2adventure11_name_resource
  ]
}
