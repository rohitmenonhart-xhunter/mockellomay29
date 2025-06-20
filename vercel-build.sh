#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "Node version:"
node --version

echo "NPM version:"
npm --version

echo "Creating static directory..."
mkdir -p static

echo "Creating static HTML file with Clerk production configuration..."
cat > static/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Mockello</title>
  <script type="text/javascript">
    // Clerk configuration
    window.__clerk_frontend_api = 'https://accounts.mockello.com';
    window.__clerk_publishable_key = 'pk_live_Y2xlcmsubW9ja2VsbG8uY29tJA';
  </script>
  <script crossorigin src="https://accounts.mockello.com/npm/@clerk/clerk-js@4/dist/clerk.browser.js"></script>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      background-color: #f5f5f5;
    }
    .container {
      text-align: center;
      padding: 2rem;
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      max-width: 500px;
      width: 100%;
    }
    h1 {
      color: #333;
      margin-bottom: 1rem;
    }
    p {
      color: #666;
      line-height: 1.6;
    }
    .logo {
      width: 100px;
      height: 100px;
      margin-bottom: 1rem;
      background-color: #000;
      border-radius: 50%;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-weight: bold;
      font-size: 24px;
    }
    .button {
      display: inline-block;
      background-color: #000;
      color: white;
      padding: 0.75rem 1.5rem;
      border-radius: 4px;
      text-decoration: none;
      margin-top: 1rem;
      font-weight: 500;
    }
    #auth-container {
      margin-top: 2rem;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="logo">M</div>
    <h1>Welcome to Mockello</h1>
    <p>
      Sign in to access your account.
    </p>
    <div id="auth-container"></div>
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', async function() {
      try {
        // Initialize Clerk with production configuration
        const clerk = window.Clerk;
        await clerk.load({
          publishableKey: window.__clerk_publishable_key,
          frontendApi: window.__clerk_frontend_api
        });
        
        // Mount the sign-in component
        const signInDiv = document.getElementById('auth-container');
        clerk.mountSignIn(signInDiv);
      } catch (error) {
        console.error('Error initializing Clerk:', error);
        // Fallback to direct link if Clerk fails to load
        const authContainer = document.getElementById('auth-container');
        authContainer.innerHTML = '<a href="https://accounts.mockello.com/sign-in" class="button">Sign In</a>';
      }
    });
  </script>
</body>
</html>
EOF

echo "Static build completed successfully!" 