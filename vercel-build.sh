#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "Node version:"
node --version

echo "NPM version:"
npm --version

echo "Workspace contents:"
ls -la

echo "Installing dependencies..."
npm install --no-save vite@5.4.1 @vitejs/plugin-react-swc@3.5.0

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