- name: Deploy Bicep (Storage + Static Website)
  uses: azure/CLI@v2
  with:
    inlineScript: |
      RG="rg-labs" 
      LOCATION="uksouth"   # example: uksouth / ukwest / westeurope etc.
      STG="${{ secrets.AZURE_STORAGE_ACCOUNT }}"

      ls -la
      ls -la infra

      az deployment group create \
        --resource-group "$RG" \
        --template-file "infra/main.bicep" \
        --parameters location="$LOCATION" storageAccountName="$STG"
