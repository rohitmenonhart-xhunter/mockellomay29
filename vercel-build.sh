#!/bin/bash
echo "Installing dependencies..."
npm install --legacy-peer-deps

echo "Checking Vite installation..."
if ! [ -x "$(command -v ./node_modules/.bin/vite)" ]; then
  echo "Vite not found in node_modules, installing specific version..."
  npm install vite@5.4.1 --no-save
fi

echo "Running build..."
./node_modules/.bin/vite build 