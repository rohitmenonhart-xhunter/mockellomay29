#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "Node version:"
node --version

echo "NPM version:"
npm --version

echo "Workspace contents:"
ls -la

echo "Using simplified package.json for build..."
if [ -f "package-override.json" ]; then
  cp package-override.json package.json
fi

echo "Ensuring index.html exists..."
if [ ! -f "index.html" ] && [ -f "index.html.backup" ]; then
  cp index.html.backup index.html
fi

echo "Installing minimal dependencies..."
npm install --no-save

echo "Creating minimal vite.config.js..."
cat > vite.config.js << 'EOF'
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react-swc';
import path from 'path';

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  build: {
    outDir: 'dist',
  }
});
EOF

echo "Running build with direct Vite command..."
npx vite build --config vite.config.js 