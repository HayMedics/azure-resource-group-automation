#!/bin/bash

# ------------------------------------------------------------
# create_rg.sh
# Automatically creates Azure resource groups for a project
# across 4 environments: Dev, Test, UAT, Production.
#
# Usage:
#   ./create_rg.sh <ProjectName>
#
# Example:
#   ./create_rg.sh Project-A
#   --> creates Project-A-Dev-RG, Project-A-Test-RG,
#       Project-A-UAT-RG, Project-A-Production-RG
# ------------------------------------------------------------

# The Azure region where resource groups will be created.
# Change this if you work in a different region.
LOCATION="eastus"

# Step 1: Take the project name the user typed after the script.
PROJECT_NAME=$1

# Step 2: Safety check - stop early if no name was given.
if [ -z "$PROJECT_NAME" ]; then
  echo "Error: No project name provided."
  echo "Usage: ./create_rg.sh <ProjectName>"
  echo "Example: ./create_rg.sh Project-A"
  exit 1
fi

# Step 3: The list of environments we want a resource group for.
ENVIRONMENTS=("Dev" "Test" "UAT" "Production")

echo "Creating resource groups for project: $PROJECT_NAME"
echo "-----------------------------------------------------"

# Step 4: Loop through each environment and create its resource group.
for ENV in "${ENVIRONMENTS[@]}"; do
  RG_NAME="${PROJECT_NAME}-${ENV}-RG"
  echo "Creating: $RG_NAME (location: $LOCATION)"
  az group create --name "$RG_NAME" --location "$LOCATION"
done

echo "-----------------------------------------------------"
echo "Done! All resource groups for '$PROJECT_NAME' created."
