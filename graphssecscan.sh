# This script fetches all security alerts for a given repository in an organization
# It uses the GitHub CLI to authenticate and fetch the alerts
# It uses jq to parse the JSON response

# authenticate to GitHub
gh auth login

# Set your organization name
ORG_NAME="Atmosera-adv-sec-prep"

# Set your repository name
REPO_NAME="swiss-cheese"


# Create a GraphQL query to fetch security alerts for a repository
# Details about the query:
# It fetches the first 100 alerts
# It fetches the createdAt, dismissedAt, package name, severity, and updatedAt for each alert
QUERY='
query {
  repository(owner: "'$ORG_NAME'", name: "'$REPO_NAME'") {
    vulnerabilityAlerts(first: 100) {
      nodes {
        createdAt
        dismissedAt
        securityVulnerability {
          package {
            
            name
          }
          severity
          updatedAt
        }
      }
    }
  }
}'

# Fetch the security alerts using the GraphQL query
ALERTS=$(gh api graphql -f query="$QUERY")

# Print all alerts
echo $ALERTS | jq -r '.data.repository.vulnerabilityAlerts.nodes[]'