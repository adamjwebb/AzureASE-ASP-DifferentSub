targetScope = 'subscription'

@description('Array of actions for the roleDefinition')
param actions array = [
  'Microsoft.Web/hostingEnvironments/Join/Action'
]

@description('Array of notActions for the roleDefinition')
param notActions array = []

@description('Friendly name of the role definition')
param roleName string = 'Custom Role - Join App Service Plan to App Service Environment'

var roleDefName = guid(subscription().id, string(actions), string(notActions))

resource roleDef 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: roleDefName
  properties: {
    roleName: roleName
    type: 'customRole'
    permissions: [
      {
        actions: actions
        notActions: notActions
      }
    ]
    assignableScopes: [
      subscription().id
    ]
  }
}
