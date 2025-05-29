#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "Node version:"
node --version

echo "NPM version:"
npm --version

echo "Installing dependencies with force flag..."
npm install --force

echo "Checking for Vite..."
if [ ! -f "./node_modules/.bin/vite" ]; then
  echo "Vite binary not found, installing globally..."
  npm install -g vite
  
  echo "Creating directory structure if needed..."
  mkdir -p ./node_modules/.bin
  
  echo "Checking global vite installation..."
  which vite
  
  echo "Running build with global Vite..."
  vite build
else
  echo "Running build with local Vite..."
  ./node_modules/.bin/vite build
fi 