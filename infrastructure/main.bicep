param virtualMachines_VM1_name string = 'VM1'
param virtualNetworks_vnet_name string = 'vnet'
param sshPublicKeys_VM1_key_name string = 'VM1_key'
param networkInterfaces_vm1828_name string = 'vm1828'
param publicIPAddresses_vng_pip_name string = 'vng-pip'
param networkSecurityGroups_VM1_nsg_name string = 'VM1-nsg'
param virtualNetworkGateways_vng_p2s_name string = 'vng-p2s'

resource sshPublicKeys_VM1_key_name_resource 'Microsoft.Compute/sshPublicKeys@2026-04-01' = {
  name: sshPublicKeys_VM1_key_name
  location: 'eastus'
  properties: {
    publicKey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6W/hMfi/g46c9RJU62N8Pr4Po+nmCWa2xpORqdgX6ZWKU8hPgk/J/Rt3EiDLnzjxwMBGVPG4F9201wzjv0ZpXa7UNhjhrmMk03ZgN0Z7dC5N8WZVmby/9hGZ88SfZtGCQejK50V2BjUKmc+9kpvLrnOM9uyRgo7wdlI4K8w3DLxI1G2q9HgO0++lW8H1bfuzg9MVyaHdud3+8aXF5qnjh/kA181A5IuQNfPaJ7tXl8Jt+l2vPWF4NQQ444kFeBx9gXTGymENWQl1s0Dh9rb2LcEspg48xh8apDCV8SiHFSWoEaNET/rAs0ed0330RiOH1x6D020MrIQSLsfKtFt3Klng2muxpv84RKoBW8ezQmw2PRAxH1TfX566MQbb/q5kHN+843dWhijuZFGTZ5eaxRLHIyT3aTSqnq0ezO/230BPnQj8Qvx4AmvOcoVxDtpcEJwRAjyY8jwRvA/aOkAMsv+zouCcFTaxbl49Ho/nmSuZuqe7TswtnvXcPYMnV0O0= generated-by-azure'
  }
}

resource networkSecurityGroups_VM1_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2025-09-01' = {
  name: networkSecurityGroups_VM1_nsg_name
  location: 'eastus'
  properties: {
    securityRules: [
      {
        name: 'SSH'
        id: networkSecurityGroups_VM1_nsg_name_SSH.id
        properties: {
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          priority: 300
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource publicIPAddresses_vng_pip_name_resource 'Microsoft.Network/publicIPAddresses@2025-09-01' = {
  name: publicIPAddresses_vng_pip_name
  location: 'eastus'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource virtualNetworks_vnet_name_resource 'Microsoft.Network/virtualNetworks@2025-09-01' = {
  name: virtualNetworks_vnet_name
  location: 'eastus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'default'
        id: virtualNetworks_vnet_name_default.id
        properties: {
          addressPrefixes: [
            '10.0.0.0/24'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
      {
        name: 'GatewaySubnet'
        id: virtualNetworks_vnet_name_GatewaySubnet.id
        properties: {
          addressPrefixes: [
            '10.0.1.0/26'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualMachines_VM1_name_resource 'Microsoft.Compute/virtualMachines@2026-04-01' = {
  name: virtualMachines_VM1_name
  location: 'eastus'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2als_v6'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'server'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_VM1_name}_OsDisk_1_5897a8720f174ec9aa4d907d2b9593ac'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_VM1_name}_OsDisk_1_5897a8720f174ec9aa4d907d2b9593ac'
          )
        }
        deleteOption: 'Delete'
      }
      dataDisks: []
      diskControllerType: 'NVMe'
    }
    osProfile: {
      computerName: virtualMachines_VM1_name
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/azureuser/.ssh/authorized_keys'
              keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6W/hMfi/g46c9RJU62N8Pr4Po+nmCWa2xpORqdgX6ZWKU8hPgk/J/Rt3EiDLnzjxwMBGVPG4F9201wzjv0ZpXa7UNhjhrmMk03ZgN0Z7dC5N8WZVmby/9hGZ88SfZtGCQejK50V2BjUKmc+9kpvLrnOM9uyRgo7wdlI4K8w3DLxI1G2q9HgO0++lW8H1bfuzg9MVyaHdud3+8aXF5qnjh/kA181A5IuQNfPaJ7tXl8Jt+l2vPWF4NQQ444kFeBx9gXTGymENWQl1s0Dh9rb2LcEspg48xh8apDCV8SiHFSWoEaNET/rAs0ed0330RiOH1x6D020MrIQSLsfKtFt3Klng2muxpv84RKoBW8ezQmw2PRAxH1TfX566MQbb/q5kHN+843dWhijuZFGTZ5eaxRLHIyT3aTSqnq0ezO/230BPnQj8Qvx4AmvOcoVxDtpcEJwRAjyY8jwRvA/aOkAMsv+zouCcFTaxbl49Ho/nmSuZuqe7TswtnvXcPYMnV0O0= generated-by-azure'
            }
          ]
        }
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
        enableVMAgentPlatformUpdates: true
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
      adminUsername: 'azureuser'
    }
    securityProfile: {
      securityType: 'Standard'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm1828_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
  }
}

resource networkSecurityGroups_VM1_nsg_name_SSH 'Microsoft.Network/networkSecurityGroups/securityRules@2025-09-01' = {
  name: '${networkSecurityGroups_VM1_nsg_name}/SSH'
  properties: {
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    priority: 300
    protocol: 'Tcp'
    access: 'Allow'
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_VM1_nsg_name_resource
  ]
}

resource virtualNetworks_vnet_name_default 'Microsoft.Network/virtualNetworks/subnets@2025-09-01' = {
  name: '${virtualNetworks_vnet_name}/default'
  properties: {
    addressPrefixes: [
      '10.0.0.0/24'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_vnet_name_resource
  ]
}

resource virtualNetworks_vnet_name_GatewaySubnet 'Microsoft.Network/virtualNetworks/subnets@2025-09-01' = {
  name: '${virtualNetworks_vnet_name}/GatewaySubnet'
  properties: {
    addressPrefixes: [
      '10.0.1.0/26'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_vnet_name_resource
  ]
}

resource networkInterfaces_vm1828_name_resource 'Microsoft.Network/networkInterfaces@2025-09-01' = {
  name: networkInterfaces_vm1828_name
  location: 'eastus'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm1828_name_resource.id}/ipConfigurations/ipconfig1'
        properties: {
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_vnet_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_VM1_nsg_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource virtualNetworkGateways_vng_p2s_name_resource 'Microsoft.Network/virtualNetworkGateways@2025-09-01' = {
  name: virtualNetworkGateways_vng_p2s_name
  location: 'eastus'
  properties: {
    enablePrivateIpAddress: false
    virtualNetworkGatewayMigrationStatus: {
      state: 'None'
      phase: 'None'
    }
    ipConfigurations: [
      {
        name: 'default'
        id: '${virtualNetworkGateways_vng_p2s_name_resource.id}/ipConfigurations/default'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_vng_pip_name_resource.id
          }
          subnet: {
            id: virtualNetworks_vnet_name_GatewaySubnet.id
          }
        }
      }
    ]
    natRules: []
    virtualNetworkGatewayPolicyGroups: []
    enableBgpRouteTranslationForNat: false
    disableIPSecReplayProtection: false
    sku: {
      name: 'VpnGw1AZ'
      tier: 'VpnGw1AZ'
    }
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    enableBgp: false
    enableHighBandwidthVpnGateway: false
    activeActive: false
    vpnClientConfiguration: {
      vpnClientAddressPool: {
        addressPrefixes: [
          '172.16.0.0/24'
        ]
      }
      vpnClientProtocols: [
        'OpenVPN'
      ]
      vpnAuthenticationTypes: [
        'AAD'
      ]
      vpnClientRootCertificates: []
      vpnClientRevokedCertificates: []
      vngClientConnectionConfigurations: []
      radiusServers: []
      vpnClientIpsecPolicies: []
      aadTenant: 'https://login.microsoftonline.com/a7155d68-b258-4a28-861d-6564275b93c7/'
      aadAudience: '41b23e61-6c1e-4545-b367-cd054e0ed4b4'
      aadIssuer: 'https://sts.windows.net/a7155d68-b258-4a28-861d-6564275b93c7/'
    }
    bgpSettings: {
      asn: 65515
      bgpPeeringAddress: '10.0.1.62'
      peerWeight: 0
      bgpPeeringAddresses: [
        {
          ipconfigurationId: '${virtualNetworkGateways_vng_p2s_name_resource.id}/ipConfigurations/default'
          customBgpIpAddresses: []
        }
      ]
    }
    customRoutes: {
      addressPrefixes: []
    }
    vpnGatewayGeneration: 'Generation2'
    allowRemoteVnetTraffic: false
    allowVirtualWanTraffic: false
  }
}
