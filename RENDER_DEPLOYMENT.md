# Deploying n8n on Render

This guide will help you deploy n8n on Render.com using the provided `render.yaml` blueprint.

## Prerequisites

1. A [Render account](https://render.com)
2. Your n8n repository with the `render.yaml` file

## Deployment Steps

### Option 1: Deploy using Blueprint

1. Log in to your Render account
2. Go to the Dashboard and click on "New" then "Blueprint"
3. Connect your GitHub repository containing this n8n code and the `render.yaml` file
4. Select the repository and click "Apply Blueprint"
5. Render will automatically set up both the n8n web service and PostgreSQL database as defined in `render.yaml`
6. The deployment process will start automatically

### Option 2: Manual Setup

If you prefer to set up your services manually:

#### Step 1: Create a PostgreSQL Database

1. In your Render dashboard, go to "New" and select "PostgreSQL"
2. Configure your database:
   - Name: `n8n-postgres`
   - Database: `n8n`
   - User: Leave as auto-generated
   - Region: Choose the closest to your users
   - Plan: Select appropriate plan for your needs
3. Click "Create Database" and note the connection details

#### Step 2: Create Web Service for n8n

1. In your Render dashboard, go to "New" and select "Web Service"
2. Connect your GitHub repository
3. Configure the web service:
   - Name: `n8n`
   - Environment: `Node`
   - Region: Choose the same region as your database
   - Branch: `main` or your preferred branch
   - Build Command: `npm install -g n8n`
   - Start Command: `n8n start`
4. Add the following environment variables:
   - `NODE_ENV`: `production`
   - `GENERIC_TIMEZONE`: Your timezone (e.g., `UTC`)
   - `TZ`: Your timezone (e.g., `UTC`)
   - `N8N_ENCRYPTION_KEY`: Generate a secure random string
   - `DB_TYPE`: `postgresdb`
   - `DB_POSTGRESDB_HOST`: Your Postgres host from step 1
   - `DB_POSTGRESDB_PORT`: Your Postgres port (usually `5432`)
   - `DB_POSTGRESDB_DATABASE`: `n8n`
   - `DB_POSTGRESDB_USER`: Your Postgres user from step 1
   - `DB_POSTGRESDB_PASSWORD`: Your Postgres password from step 1
   - `N8N_PROTOCOL`: `https`
   - `N8N_PORT`: `5678`
   - `N8N_HOST`: Your app's domain (e.g., `n8n.onrender.com`)
   - `N8N_PATH`: `/`
5. Click "Create Web Service"

## Post-Deployment Configuration

After successful deployment:

1. Open your n8n instance by clicking on the provided URL
2. Follow the setup wizard to create your admin user
3. Configure any additional settings through the n8n UI

## Important Notes

- Render automatically provides HTTPS, so your n8n instance will be secure
- Ensure your encryption key (`N8N_ENCRYPTION_KEY`) is securely stored as it's needed to decrypt credentials
- For webhooks to work properly, make sure your `N8N_HOST` is set correctly
- The free tier has limitations - consider upgrading to a paid plan for production use

## Troubleshooting

If you encounter issues:

1. Check the service logs in your Render dashboard
2. Verify all environment variables are correctly set
3. Ensure the database connection is working properly
4. You may need to restart the web service after changing environment variables

For more information, refer to the [n8n documentation](https://docs.n8n.io) and [Render documentation](https://render.com/docs). 